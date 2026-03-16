variable "service_name" {
  type        = string
  description = "サービス名"
}

variable "env" {
  type        = string
  description = "環境名(stg, prodなど)"
}

variable "origin_arn" {
  type        = string
  description = "CloudFront VPC originが参照するALBのARN"
}

variable "origin_domain_name" {
  type        = string
  description = "CloudFront originに設定するALBのDNS名"
}
