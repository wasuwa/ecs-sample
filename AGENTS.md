## 全体方針

- 日本語で回答してください。
- 日本語と英語の間に半角スペースを入れないでください。
- [一般的なスタイルと構造に関するベストプラクティス](https://docs.cloud.google.com/docs/terraform/best-practices/general-style-structure?hl=ja)に従ってください。

## プロジェクト概要

ECSで構築するWeb APIサーバー

## 命名規則

AWSリソースの命名規則は`web-api-{env}`をベースにしてください。
`{env}`には`stg`や`prod`などの環境名を入れます。

## ディレクトリ構造

Terraform関連のファイルは`terraform/`配下に集約し、ルートモジュールと再利用モジュールを分離する構成を推奨します。
ECSサービス、タスクは`ecspresso/`配下に集約します。

### 構成方針

- `terraform/modules/`は再利用可能なTerraformモジュールを配置します。各リソースは`main.tf`に集約します。
- `terraform/environments/`はTerraformを実行するルートモジュールです。`stg`、`prod`ごとに状態を分離します。
- ルートモジュールでは共通処理を直接書き込まず、`terraform/modules/`のモジュールを呼び出して環境差分だけを`terraform.tfvars`で与えます。

### ファイル分割ルール

- 変数は`variables.tf`、出力は`outputs.tf`、ProviderとTerraformバージョン制約は`versions.tf`に集約します。
- データソースは参照先リソースの近くに置き、多くなった場合のみ`data.tf`を追加します。
- 命名はTerraformの慣例に合わせてスネークケースを使用し、単一の主要リソースは`main`を優先します。
