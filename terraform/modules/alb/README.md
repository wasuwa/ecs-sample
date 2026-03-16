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
| [aws_lb.main](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/lb) | resource |
| [aws_lb_listener.main](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.main](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/lb_target_group) | resource |
| [aws_security_group.main](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ingress_prefix_list_ids"></a> [allowed\_ingress\_prefix\_list\_ids](#input\_allowed\_ingress\_prefix\_list\_ids) | ALBへのHTTPアクセスを許可するprefix list ID一覧 | `list(string)` | `[]` | no |
| <a name="input_env"></a> [env](#input\_env) | 環境名(stg, prodなど) | `string` | n/a | yes |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | ターゲットグループのヘルスチェックパス | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | サービス名 | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | ALBを配置するサブネットID一覧 | `list(string)` | n/a | yes |
| <a name="input_target_port"></a> [target\_port](#input\_target\_port) | ターゲットグループが転送するアプリケーションの待受ポート | `number` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPCのID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | ALBのDNS名 |
| <a name="output_load_balancer_arn"></a> [load\_balancer\_arn](#output\_load\_balancer\_arn) | ALBのARN |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ALB用セキュリティグループのID |
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | ALBターゲットグループのARN |
<!-- END_TF_DOCS -->