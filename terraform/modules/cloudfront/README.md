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
| [aws_cloudfront_distribution.main](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_vpc_origin.main](https://registry.terraform.io/providers/hashicorp/aws/6.36.0/docs/resources/cloudfront_vpc_origin) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | 環境名(stg, prodなど) | `string` | n/a | yes |
| <a name="input_origin_arn"></a> [origin\_arn](#input\_origin\_arn) | CloudFront VPC originが参照するALBのARN | `string` | n/a | yes |
| <a name="input_origin_domain_name"></a> [origin\_domain\_name](#input\_origin\_domain\_name) | CloudFront originに設定するALBのDNS名 | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | サービス名 | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_distribution_domain_name"></a> [distribution\_domain\_name](#output\_distribution\_domain\_name) | CloudFront distributionのドメイン名 |
| <a name="output_distribution_hosted_zone_id"></a> [distribution\_hosted\_zone\_id](#output\_distribution\_hosted\_zone\_id) | CloudFront distributionのRoute53 Hosted Zone ID |
| <a name="output_distribution_id"></a> [distribution\_id](#output\_distribution\_id) | CloudFront distributionのID |
<!-- END_TF_DOCS -->