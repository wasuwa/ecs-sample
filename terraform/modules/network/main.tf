locals {
  route_table_keys = toset([
    for subnet in values(var.subnets) : subnet.key
  ])
}

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
  for_each                = var.subnets
  cidr_block              = each.value.cidr_block
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = false
  availability_zone       = each.value.availability_zone

  tags = {
    Name = "${var.service_name}-${var.env}-${each.key}-subnet"
    Env  = var.env
  }
}

resource "aws_route_table" "main" {
  for_each = local.route_table_keys
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "${var.service_name}-${var.env}-${each.key}-route-table"
    Env  = var.env
  }
}

resource "aws_route_table_association" "main" {
  for_each       = var.subnets
  route_table_id = aws_route_table.main[each.value.key].id
  subnet_id      = aws_subnet.main[each.key].id
}
