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

variable "subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
    key               = string
  }))
  description = "サブネット定義"

  validation {
    condition = (
      length(
        setintersection([
          for subnet in values(var.subnets) : (
            can(cidrhost(subnet.cidr_block, 0)) ? subnet.cidr_block : null
          )
          ], [
          for subnet in values(var.subnets) : subnet.cidr_block
        ])
      ) == length(var.subnets)
    )
    error_message = "サブネットのCIDRブロックが不正な形式です"
  }

  validation {
    condition = alltrue([
      for subnet in values(var.subnets) :
      length(trimspace(subnet.key)) > 0
    ])
    error_message = "subnets.keyには空文字以外を指定してください"
  }

  validation {
    condition = alltrue([
      for subnet in values(var.subnets) :
      contains(data.aws_availability_zones.main.names, subnet.availability_zone)
    ])
    error_message = "サブネットのavailability_zoneは利用可能なAZを指定してください"
  }
}
