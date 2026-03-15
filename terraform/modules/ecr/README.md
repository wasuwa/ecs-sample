<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.14.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 6.36.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.36.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.main](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.main](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/ecr_repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | 環境名(stg, prodなど) | `string` | n/a | yes |
| <a name="input_image_tag_mutability"></a> [image\_tag\_mutability](#input\_image\_tag\_mutability) | タグの上書きを許容するか（MUTABLE、IMMUTABLE） | `string` | `"IMMUTABLE"` | no |
| <a name="input_lifecycle_policy"></a> [lifecycle\_policy](#input\_lifecycle\_policy) | リポジトリのライフサイクルポリシーJSON。nullの場合は未タグイメージを30日で削除するデフォルトポリシーを使用 | `string` | `null` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | サービス名 | `string` | n/a | yes |
| <a name="input_service_role_name"></a> [service\_role\_name](#input\_service\_role\_name) | リポジトリに格納するイメージのサービス内ロール | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repository_arn"></a> [repository\_arn](#output\_repository\_arn) | ECRリポジトリのARN |
| <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url) | ECRリポジトリのURL |
<!-- END_TF_DOCS -->