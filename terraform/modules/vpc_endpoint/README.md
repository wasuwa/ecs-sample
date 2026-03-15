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
| [aws_security_group.main](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/security_group) | resource |
| [aws_vpc_endpoint.ecr_api](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ecr_dkr](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.logs](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.s3](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/vpc_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | Interface型VPCエンドポイントへのHTTPS通信を許可するCIDR一覧 | `list(string)` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | 環境名(stg, prodなど) | `string` | n/a | yes |
| <a name="input_gateway_route_table_ids"></a> [gateway\_route\_table\_ids](#input\_gateway\_route\_table\_ids) | Gateway型VPCエンドポイントを関連付けるルートテーブルID一覧 | `list(string)` | n/a | yes |
| <a name="input_interface_subnet_ids"></a> [interface\_subnet\_ids](#input\_interface\_subnet\_ids) | Interface型VPCエンドポイントを配置するサブネットID一覧 | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWSリージョン | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | サービス名 | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPCのID | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->