module "vpc" {
  source         = "../../modules/network"
  service_name   = var.service_name
  env            = var.env
  vpc_cidr_block = var.vpc_cidr_block
  subnets        = var.subnets
}

# module "vpc_endpoint" {
#   source                  = "../../modules/vpc_endpoint"
#   service_name            = var.service_name
#   env                     = var.env
#   region                  = var.region
#   vpc_id                  = module.vpc.vpc_id
#   interface_subnet_ids    = module.vpc.subnet_ids_by_key["endpoint"]
#   gateway_route_table_ids = [module.vpc.route_table_ids["private"]]
#   allowed_cidr_blocks     = module.vpc.subnet_cidr_blocks_by_key["private"]
# }

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
