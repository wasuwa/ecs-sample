module "vpc" {
  source             = "../../modules/network"
  service_name       = var.service_name
  env                = var.env
  vpc_cidr_block     = var.vpc_cidr_block
  subnet_cidr_blocks = var.subnet_cidr_blocks
}

module "ecr" {
  source            = "../../modules/ecr"
  service_name      = var.service_name
  env               = var.env
  service_role_name = var.service_role_name
}

module "cluster" {
  source                    = "../../modules/ecs/cluster"
  service_name              = var.service_name
  env                       = var.env
  enable_container_insights = var.enable_container_insights
}
