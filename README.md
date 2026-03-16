# ECSサンプル（勉強用）

ECS Fargateで稼働するWeb APIサーバーのサンプル構成です。

## 構成

このリポジトリでは、CloudFrontを公開入口にし、その背後にALBとECS Fargateを配置する構成を採用しています。
アプリケーションはプライベートサブネット上で稼働します。

主な通信経路は以下のとおりです。

- 利用者はCloudFrontへHTTPSでアクセスします。
- CloudFrontはVPC Origin経由でALBへHTTPで転送します。
- 内部ALBはECS ServiceのタスクへHTTP:8080でルーティングします。
- ECSタスクはVPC Endpoint経由でAmazon ECR、CloudWatch Logs、Amazon S3へアクセスします。

## ディレクトリ構成

- `terraform/`: VPC、サブネット、VPC Endpoint、ALB、ECS Cluster、ECR、CloudFrontなどのインフラを管理します。
- `ecspresso/`: Terraformを参照しながら、ECSサービスとタスク定義を管理します。
