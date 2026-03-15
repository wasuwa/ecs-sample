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
| [aws_cloudwatch_log_group.main](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.execution](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/iam_role) | resource |
| [aws_iam_role.task](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.execution_default](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.main](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/security_group) | resource |
| [aws_iam_policy_document.main](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_security_group_id"></a> [alb\_security\_group\_id](#input\_alb\_security\_group\_id) | ALB用Security GroupのID | `string` | n/a | yes |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | アプリケーションコンテナの待受ポート | `number` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | 環境名(stg, prodなど) | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | サービス名 | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPCのID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_execution_role_arn"></a> [execution\_role\_arn](#output\_execution\_role\_arn) | Execution RoleのARN |
| <a name="output_log_group_name"></a> [log\_group\_name](#output\_log\_group\_name) | CloudWatch Logsのロググループ名 |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ECSサービス用Security GroupのID |
| <a name="output_task_role_arn"></a> [task\_role\_arn](#output\_task\_role\_arn) | Task RoleのARN |
<!-- END_TF_DOCS -->