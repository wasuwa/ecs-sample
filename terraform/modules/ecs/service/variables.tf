variable "service_name" {
  type        = string
  description = "サービス名"
}

variable "env" {
  type        = string
  description = "環境名(stg, prodなど)"
}

variable "vpc_id" {
  type        = string
  description = "VPCのID"
}

variable "alb_security_group_id" {
  type        = string
  description = "ALB用Security GroupのID"
}

variable "container_port" {
  type        = number
  description = "アプリケーションコンテナの待受ポート"
}
