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

variable "subnet_ids" {
  type        = list(string)
  description = "ALBを配置するサブネットID一覧"
}

variable "allowed_ingress_cidr_blocks" {
  type        = list(string)
  description = "ALBへのHTTPアクセスを許可するCIDR一覧"
}

variable "target_port" {
  type        = number
  description = "ターゲットグループが転送するアプリケーションの待受ポート"
}

variable "health_check_path" {
  type        = string
  description = "ターゲットグループのヘルスチェックパス"
}
