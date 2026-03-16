output "distribution_id" {
  description = "CloudFront distributionのID"
  value       = aws_cloudfront_distribution.main.id
}

output "distribution_domain_name" {
  description = "CloudFront distributionのドメイン名"
  value       = aws_cloudfront_distribution.main.domain_name
}

output "distribution_hosted_zone_id" {
  description = "CloudFront distributionのRoute53 Hosted Zone ID"
  value       = aws_cloudfront_distribution.main.hosted_zone_id
}
