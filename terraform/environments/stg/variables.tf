variable "region" {
  description = "AWSリージョン"
  type        = string
}

variable "service_name" {
  description = "サービス名"
  type        = string
}

variable "env" {
  description = "環境名"
  type        = string
}

variable "service_role_name" {
  description = "サービス内のロール名"
  type        = string
}

variable "enable_container_insights" {
  description = "CloudWatch Container Insightsを有効化するか"
  type        = bool
}

variable "vpc_cidr_block" {
  description = "VPCのCIDRブロック"
  type        = string
}

variable "subnets" {
  description = "サブネット定義"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    key               = string
  }))
}
