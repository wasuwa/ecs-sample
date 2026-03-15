module "vpc" {
  source             = "../../modules/network"
  service_name       = var.service_name
  env                = var.env
  vpc_cidr_block     = var.vpc_cidr_block
  subnet_cidr_blocks = var.subnet_cidr_blocks
}
