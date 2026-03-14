## 全体方針
- 日本語で回答してください。
- 日本語と英語の間に半角スペースを入れないでください。
- [一般的なスタイルと構造に関するベストプラクティス](https://docs.cloud.google.com/docs/terraform/best-practices/general-style-structure?hl=ja)に従ってください。

## プロジェクト概要
ECSで構築するWeb APIサーバー

## ディレクトリ構造
Terraform関連のファイルは、`README.md`と`docs/`を除いて`terraform/`配下に集約し、ルートモジュールと再利用モジュールを分離する構成を推奨します。

```text
.
├── README.md
├── docs/
│   ├── architecture.md
│   ├── operations.md
│   └── decisions/
└── terraform/
    ├── modules/
    │   ├── network/
    │   │   ├── main.tf
    │   │   ├── variables.tf
    │   │   ├── outputs.tf
    │   │   ├── versions.tf
    │   │   └── README.md
    │   ├── ecs_service/
    │   │   ├── main.tf
    │   │   ├── iam.tf
    │   │   ├── logs.tf
    │   │   ├── variables.tf
    │   │   ├── outputs.tf
    │   │   ├── versions.tf
    │   │   └── README.md
    │   ├── alb/
    │   │   ├── main.tf
    │   │   ├── variables.tf
    │   │   ├── outputs.tf
    │   │   ├── versions.tf
    │   │   └── README.md
    │   └── ecr/
    │       ├── main.tf
    │       ├── variables.tf
    │       ├── outputs.tf
    │       ├── versions.tf
    │       └── README.md
    ├── environments/
    │   ├── stg/
    │   │   ├── backend.tf
    │   │   ├── main.tf
    │   │   ├── terraform.tfvars
    │   │   ├── variables.tf
    │   │   ├── outputs.tf
    │   │   └── versions.tf
    │   └── prod/
    │       ├── backend.tf
    │       ├── main.tf
    │       ├── terraform.tfvars
    │       ├── variables.tf
    │       ├── outputs.tf
    │       └── versions.tf
    ├── examples/
    │   └── ecs_service_minimal/
    │       ├── main.tf
    │       └── README.md
    ├── files/
    │   └── container-definition.json
    ├── templates/
    │   └── container-definition.json.tftpl
    ├── scripts/
    │   └── bootstrap.sh
    └── helpers/
        └── tfenv.sh
```

### 構成方針
- `terraform/modules/`は再利用可能なTerraformモジュールを配置します。各モジュールは`main.tf`を起点にし、必要に応じて`iam.tf`、`logs.tf`、`network.tf`のように論理単位で分割します。
- `terraform/environments/`はTerraformを実行するルートモジュールです。`stg`、`prod`ごとに状態を分離し、各ディレクトリに`backend.tf`と`main.tf`を置きます。
- ルートモジュールでは共通処理を直接書き込まず、`terraform/modules/`のモジュールを呼び出して環境差分だけを`terraform.tfvars`で与えます。
- モジュール直下にはTerraformファイルと`README.md`などのメタデータだけを置き、追加ドキュメントは`docs/`に分離します。
- `terraform/examples/`には利用例を置き、モジュールの入出力や最小構成が分かるようにします。
- Terraformから実行するスクリプトは`terraform/scripts/`、Terraformから直接実行しない補助スクリプトは`terraform/helpers/`に分離します。
- Terraformが参照する静的ファイルは`terraform/files/`、`templatefile()`で読むテンプレートは`terraform/templates/`に配置します。

### ファイル分割ルール
- 変数は`variables.tf`、出力は`outputs.tf`、ProviderとTerraformバージョン制約は`versions.tf`に集約します。
- リソースは1ファイル1リソースではなく、責務単位でまとめます。例:ECSサービス本体は`main.tf`、IAMは`iam.tf`、CloudWatch Logsは`logs.tf`。
- データソースは参照先リソースの近くに置き、多くなった場合のみ`data.tf`を追加します。
- 命名はTerraformの慣例に合わせてスネークケースを使用し、単一の主要リソースは`main`を優先します。

### このプロジェクトでの適用イメージ
- `terraform/modules/network`: VPC、subnet、security groupなどネットワーク関連
- `terraform/modules/ecr`: ECRリポジトリ
- `terraform/modules/alb`: ALB、listener、target group
- `terraform/modules/ecs_service`: ECS cluster、task definition、service、task role、log group
- `terraform/environments/*`: 環境ごとのCIDR、Desired Count、ドメイン名、Stateバックエンド設定
