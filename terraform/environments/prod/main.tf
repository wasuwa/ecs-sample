data "aws_ec2_managed_prefix_list" "cloudfront_origin_facing" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}

module "vpc" {
  source         = "../../modules/network"
  service_name   = var.service_name
  env            = var.env
  vpc_cidr_block = var.vpc_cidr_block
  subnets        = var.subnets
}

module "vpc_endpoint" {
  source                  = "../../modules/vpc_endpoint"
  service_name            = var.service_name
  env                     = var.env
  region                  = var.region
  vpc_id                  = module.vpc.vpc_id
  interface_subnet_ids    = module.vpc.subnet_ids_by_key["endpoint"]
  gateway_route_table_ids = [module.vpc.route_table_ids["app"]]
  allowed_cidr_blocks     = module.vpc.subnet_cidr_blocks_by_key["app"]
}

module "ecr" {
  source            = "../../modules/ecr"
  service_name      = var.service_name
  env               = var.env
  service_role_name = var.service_role_name
}

module "alb" {
  source       = "../../modules/alb"
  service_name = var.service_name
  env          = var.env
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.subnet_ids_by_key["app"]
  allowed_ingress_prefix_list_ids = [
    data.aws_ec2_managed_prefix_list.cloudfront_origin_facing.id
  ]
  target_port       = var.container_port
  health_check_path = var.health_check_path
}

module "cluster" {
  source                    = "../../modules/ecs/cluster"
  service_name              = var.service_name
  env                       = var.env
  enable_container_insights = var.enable_container_insights
}

module "service" {
  source                = "../../modules/ecs/service"
  service_name          = var.service_name
  env                   = var.env
  vpc_id                = module.vpc.vpc_id
  alb_security_group_id = module.alb.security_group_id
  container_port        = var.container_port
}

module "cloudfront" {
  source             = "../../modules/cloudfront"
  service_name       = var.service_name
  env                = var.env
  origin_arn         = module.alb.load_balancer_arn
  origin_domain_name = module.alb.dns_name
}
