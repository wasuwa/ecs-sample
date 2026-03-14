# アーキテクチャ概要

このプロジェクトは、AWS学習用として低コストで構築するWeb APIサーバーです。  
本番運用を前提とせず、`CloudFront+ALB+ECS on Fargate`を中心に最低限の構成で`hello world`を返すAPIを公開します。

## 設計方針

- `ECS`を利用する
- `CloudFront`を入口にする
- `ALB`と`ECS`は`private subnet`に配置する
- 独自ドメインは利用しない
- `DB`は持たない
- 認証機能は持たない
- `CloudFront`で`GET/HEAD`レスポンスをキャッシュする
- `NAT Gateway`は利用しない
- `VPC Endpoint`を利用する
- 学習しやすさと実務に近い構成の両立を優先する

## 採用サービス

- `Amazon CloudFront`
- `Amazon VPC`
- `Internet Gateway`
- `Private Subnet`×2
- `Application Load Balancer`
- `Amazon ECS`
- `AWS Fargate`
- `Amazon ECR`
- `Amazon CloudWatch Logs`
- `VPC Endpoint`
- `IAM Role`

## アーキテクチャ図

```text
Internet
  |
  v
Amazon CloudFront
  |
  v
CloudFront VPC Origin
(private ALBへの接続設定)
  |
  v
Application Load Balancer
(internal, private subnets)
  |
  v
ECS Service(Fargate, Desired Count=1)
  |
  v
ECS Task(hello world API, private subnets)

Taskからの外向き通信
  |- Interface Endpoint(ECR API)
  |- Interface Endpoint(ECR DKR)
  |- Gateway Endpoint(S3)
  |- Interface Endpoint(CloudWatch Logs)
```

## ネットワーク構成

### VPC

- 学習用の最小構成として1つの`VPC`を作成する
- 可用性確保のため、異なる`Availability Zone`に2つの`Private Subnet`を作成する
- `CloudFront VPC origins`の要件に合わせて、`VPC`には`Internet Gateway`をアタッチする

重要なのは、`Internet Gateway`をアタッチしても、`private subnet`のルートテーブルにデフォルトルートを向けないことです。これにより、`ALB`と`ECS`は引き続き非公開のままです。

### Subnet

- `Application Load Balancer`は2つの`Private Subnet`に配置する
- `ECS Task`も2つの`Private Subnet`に配置する
- `ECS Service`では`assign_public_ip=DISABLED`を設定する
- `Interface Endpoint`も同じ`Private Subnet`群に配置する

今回の方針では、`ECS Task`に`public IP`を付けません。`ECR`と`CloudWatch Logs`への通信は`VPC Endpoint`経由に限定します。

## リクエストフロー

1. クライアントが`CloudFront`のデフォルトドメイン名へアクセスする
2. `CloudFront`がキャッシュを確認する
3. キャッシュヒット時は`CloudFront`がそのままレスポンスを返す
4. キャッシュミス時は`CloudFront`が`CloudFront VPC Origin`経由で`internal ALB`へリクエストを転送する
5. `ALB`が`Target Group`へリクエストを転送する
6. `Target Group`が`ECS Task`へルーティングする
7. APIが`hello world`を返却し、`CloudFront`がレスポンスをキャッシュする

## ECS構成

### ECS Cluster

- 学習用のため、1つの`ECS Cluster`のみ作成する

### ECS Service

- `Launch Type`は`Fargate`
- `Desired Count`は`1`
- `ALB`配下で動作させる
- `Private Subnet`へ配置する
- `assign_public_ip=DISABLED`とする

### ECS Task Definition

- コンテナは1つ
- APIは単一エンドポイントのみ提供する
- 例:`GET /`で`hello world`を返す
- コンテナログは`awslogs`ドライバで`CloudWatch Logs`へ送る

## Load Balancer構成

- `ALB`は`internal`
- `ALB`は2つの`Private Subnet`に配置する
- `Listener`は`HTTP:80`のみ
- `Target Group`の`target_type`は`ip`

`Fargate`は`awsvpc`ネットワークモードを使うため、`Target Group`は`instance`ではなく`ip`を使います。

## CloudFront構成

- `Origin`は通常の公開`ALB DNS名`ではなく`CloudFront VPC Origin`を利用する
- 独自ドメインは使わず、`CloudFront`のデフォルトドメイン名を利用する
- `Viewer Protocol Policy`は`Allow all`とし、学習用途として`HTTP`アクセスを許容する
- `Origin Protocol Policy`は`HTTP only`とする
- `Allowed Methods`は`GET,HEAD`とする
- `Cached Methods`は`GET,HEAD`とする
- `Compress`は有効化する
- キャッシュは短めにし、最初は`TTL=60秒`程度を推奨する

今回のAPIは`hello world`を返すだけなので、`CloudFront`のキャッシュ効果を確認しやすい構成です。一方で、将来`POST`やユーザーごとに内容が変わるレスポンスを扱う場合は、キャッシュキーや`Cache Policy`を見直す必要があります。

## VPC Endpoint構成

### 必須のEndpoint

`ECS Task`を`private subnet`に置き、`NAT Gateway`を使わない場合、少なくとも以下を用意します。

- `Interface Endpoint`:`com.amazonaws.<region>.ecr.api`
- `Interface Endpoint`:`com.amazonaws.<region>.ecr.dkr`
- `Gateway Endpoint`:`com.amazonaws.<region>.s3`
- `Interface Endpoint`:`com.amazonaws.<region>.logs`

理由は次のとおりです。

- `ECR API`はイメージ情報の取得に必要
- `ECR DKR`はDocker Registry通信に必要
- `S3 Gateway Endpoint`は`ECR`のイメージレイヤー取得に必要
- `CloudWatch Logs Endpoint`は`awslogs`ドライバのログ送信に必要

### 今回は不要なEndpoint

- `Secrets Manager`
  今回はシークレットを利用しない
- `SSM`,`ssmmessages`,`ec2messages`
  今回は`ECS Exec`を使わない

## セキュリティ構成

### Security Group

#### ALB用Security Group

- `inbound`は`CloudFront managed prefix list`または`CloudFront-VPCOrigins-Service-SG`からの`80`を許可
- `outbound`:`ECS Task用Security Group`へアプリケーションポートを許可

#### ECS Task用Security Group

- `inbound`:`ALB用Security Group`からアプリケーションポートのみ許可
- `outbound`:`VPC Endpoint`向け`443`を許可

#### Interface Endpoint用Security Group

- `inbound`:`ECS Task用Security Group`から`443`を許可
- `outbound`:全許可

この構成により、`ALB`と`ECS Task`はインターネットから直接到達できず、アプリケーションの入口を`CloudFront`に限定できます。

## IAM構成

### Task Execution Role

少なくとも以下を許可します。

- `ECR`からのイメージ取得
- `CloudWatch Logs`へのログ出力

### Task Role

- 現時点では必須ではない
- 将来、アプリケーションからAWSサービスを呼び出す場合に追加する

## 監視と運用

- アプリケーションログは`CloudWatch Logs`へ出力する
- 学習用のため、最初は最低限のログ出力のみでよい
- 必要であれば後から`CloudWatch Alarm`を追加する

## コスト観点

- `NAT Gateway`を使わないため、固定費を抑えられる
- `Gateway Endpoint(S3)`には追加料金がない
- 一方で、`Interface Endpoint`は時間課金とデータ処理課金が発生する
- `CloudFront`と`ALB`の両方にコストが発生する
- `public IPv4`を使わないため、`ECS Task`の`public IP`課金は発生しない

学習用としては、`public subnet`に`ECS`を置くより実務に近く、`private subnet`運用の考え方を学びやすい構成です。

## 今回採用しないもの

- `Route 53`
- `ACM`
- `HTTPS`
- `WAF`
- `RDS`
- `ElastiCache`
- `SQS`
- `Public Subnet`上の`ALB`
- `Public Subnet`上の`ECS`
- `NAT Gateway`

## 将来の拡張候補

- `HTTPS`化のための独自ドメインと`ACM`
- `WAF`の追加
- `Auto Scaling`の有効化
- `CloudWatch Alarm`の追加
- `Blue/Green Deployment`の導入
- `ECS Exec`用の`SSM Endpoint`追加
