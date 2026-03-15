variable "service_name" {
  type        = string
  description = "サービス名"
}

variable "env" {
  type        = string
  description = "環境名(stg, prodなど)"
}

variable "region" {
  type        = string
  description = "AWSリージョン"
}

variable "vpc_id" {
  type        = string
  description = "VPCのID"
}

variable "interface_subnet_ids" {
  type        = list(string)
  description = "Interface型VPCエンドポイントを配置するサブネットID一覧"
}

variable "gateway_route_table_ids" {
  type        = list(string)
  description = "Gateway型VPCエンドポイントを関連付けるルートテーブルID一覧"
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "Interface型VPCエンドポイントへのHTTPS通信を許可するCIDR一覧"
}
