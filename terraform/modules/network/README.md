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
| [aws_route_table.main](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/route_table) | resource |
| [aws_route_table_association.main](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/route_table_association) | resource |
| [aws_subnet.main](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/vpc) | resource |
| [aws_availability_zones.main](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | 環境名(stg, prodなど) | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | サービス名 | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | サブネット定義 | <pre>map(object({<br/>    cidr_block        = string<br/>    availability_zone = string<br/>    key               = string<br/>  }))</pre> | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPCに割り当てるCIDRブロック | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route_table_ids"></a> [route\_table\_ids](#output\_route\_table\_ids) | ルートテーブルIDのマップ |
| <a name="output_subnet_cidr_blocks_by_key"></a> [subnet\_cidr\_blocks\_by\_key](#output\_subnet\_cidr\_blocks\_by\_key) | キーごとのサブネットCIDR一覧 |
| <a name="output_subnet_ids_by_key"></a> [subnet\_ids\_by\_key](#output\_subnet\_ids\_by\_key) | キーごとのサブネットID一覧 |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPCのID |
<!-- END_TF_DOCS -->