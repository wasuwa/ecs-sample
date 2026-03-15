variable "service_name" {
  type        = string
  description = "サービス名"
}

variable "env" {
  type        = string
  description = "環境名(stg, prodなど)"
}

variable "enable_container_insights" {
  type        = bool
  default     = true
  description = "CloudWatch Container Insightsを有効化するか"
}
