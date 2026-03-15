variable "service_name" {
  type        = string
  description = "サービス名"
}

variable "env" {
  type        = string
  description = "環境名(stg, prodなど)"
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPCに割り当てるCIDRブロック"

  validation {
    condition     = can(cidrhost(var.vpc_cidr_block, 0))
    error_message = "CIDRブロックが不正な形式です"
  }
}

variable "subnet_cidr_blocks" {
  type = object({
    private = map(object({
      cidr_block        = string
      availability_zone = string
    }))
  })
  description = "サブネットごとのCIDRブロック"
  # CIDRフォーマットのバリデーション
  validation {
    condition = (
      length(
        setintersection([
          for subnet in values(var.subnet_cidr_blocks.private) : (
            can(cidrhost(subnet.cidr_block, 0)) ? subnet.cidr_block : null
          )
          ], [
          for subnet in values(var.subnet_cidr_blocks.private) : subnet.cidr_block
        ])
      ) == length(var.subnet_cidr_blocks.private)
    )
    error_message = "プライベートのCIDRブロックが不正な形式です"
  }
  # 可用性確保のためのバリデーション
  validation {
    condition     = length(var.subnet_cidr_blocks.private) >= 2
    error_message = "可用性を確保するためにプライベートのCIDRブロックは2個以上を指定してください"
  }
  # 指定されたAZが利用可能なAZのいずれかであることのバリデーション
  validation {
    condition = alltrue([
      for subnet in values(var.subnet_cidr_blocks.private) :
      contains(data.aws_availability_zones.main.names, subnet.availability_zone)
    ])
    error_message = "プライベートサブネットのavailability_zoneは利用可能なAZを指定してください"
  }
}
