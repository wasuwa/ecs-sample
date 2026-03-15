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
| [aws_internet_gateway.main](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/internet_gateway) | resource |
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
| <a name="input_subnet_cidr_blocks"></a> [subnet\_cidr\_blocks](#input\_subnet\_cidr\_blocks) | サブネットごとのCIDRブロック | <pre>object({<br/>    private = map(object({<br/>      cidr_block        = string<br/>      availability_zone = string<br/>    }))<br/>  })</pre> | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPCに割り当てるCIDRブロック | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | プライベートサブネットのID一覧 |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPCのID |
<!-- END_TF_DOCS -->