resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.service_name}-${var.env}-vpc"
    Env  = var.env
  }
}

resource "aws_subnet" "main" {
  for_each                = var.subnet_cidr_blocks.private
  cidr_block              = each.value.cidr_block
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = false
  availability_zone       = each.value.availability_zone

  tags = {
    Name = "${var.service_name}-${var.env}-${each.key}-private-subnet"
    Env  = var.env
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.service_name}-${var.env}-private-route-table"
    Env  = var.env
  }
}

resource "aws_route_table_association" "main" {
  for_each       = aws_subnet.main
  route_table_id = aws_route_table.main.id
  subnet_id      = each.value.id
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.service_name}-${var.env}-igw"
    Env  = var.env
  }
}

# VPC Endpointは最後に作成する想定のため、現時点ではコメントアウトしている
# 有効化する場合は、少なくとも`region`と`vpc_endpoint_security_group_id`の入力を追加する

# resource "aws_vpc_endpoint" "ecr_api" {
#   vpc_id              = aws_vpc.main.id
#   service_name        = "com.amazonaws.${var.region}.ecr.api"
#   vpc_endpoint_type   = "Interface"
#   private_dns_enabled = true
#   subnet_ids          = values(aws_subnet.main)[*].id
#   security_group_ids  = [var.vpc_endpoint_security_group_id]
#
#   tags = {
#     Name = "${var.service_name}-${var.env}-ecr-api-endpoint"
#     Env  = var.env
#   }
# }
#
# resource "aws_vpc_endpoint" "ecr_dkr" {
#   vpc_id              = aws_vpc.main.id
#   service_name        = "com.amazonaws.${var.region}.ecr.dkr"
#   vpc_endpoint_type   = "Interface"
#   private_dns_enabled = true
#   subnet_ids          = values(aws_subnet.main)[*].id
#   security_group_ids  = [var.vpc_endpoint_security_group_id]
#
#   tags = {
#     Name = "${var.service_name}-${var.env}-ecr-dkr-endpoint"
#     Env  = var.env
#   }
# }
#
# resource "aws_vpc_endpoint" "logs" {
#   vpc_id              = aws_vpc.main.id
#   service_name        = "com.amazonaws.${var.region}.logs"
#   vpc_endpoint_type   = "Interface"
#   private_dns_enabled = true
#   subnet_ids          = values(aws_subnet.main)[*].id
#   security_group_ids  = [var.vpc_endpoint_security_group_id]
#
#   tags = {
#     Name = "${var.service_name}-${var.env}-logs-endpoint"
#     Env  = var.env
#   }
# }
#
# resource "aws_vpc_endpoint" "s3" {
#   vpc_id            = aws_vpc.main.id
#   service_name      = "com.amazonaws.${var.region}.s3"
#   vpc_endpoint_type = "Gateway"
#   route_table_ids   = [aws_route_table.main.id]
#
#   tags = {
#     Name = "${var.service_name}-${var.env}-s3-endpoint"
#     Env  = var.env
#   }
# }
