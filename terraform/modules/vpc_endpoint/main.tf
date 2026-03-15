resource "aws_security_group" "main" {
  name        = "${var.service_name}-${var.env}-vpc-endpoint-sg"
  description = "Security group for interface VPC endpoints"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTPS from application subnets"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.service_name}-${var.env}-vpc-endpoint-sg"
    Env  = var.env
  }
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.interface_subnet_ids
  security_group_ids  = [aws_security_group.main.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.service_name}-${var.env}-ecr-api-endpoint"
    Env  = var.env
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.interface_subnet_ids
  security_group_ids  = [aws_security_group.main.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.service_name}-${var.env}-ecr-dkr-endpoint"
    Env  = var.env
  }
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.interface_subnet_ids
  security_group_ids  = [aws_security_group.main.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.service_name}-${var.env}-logs-endpoint"
    Env  = var.env
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.gateway_route_table_ids

  tags = {
    Name = "${var.service_name}-${var.env}-s3-endpoint"
    Env  = var.env
  }
}
