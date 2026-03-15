resource "aws_ecs_cluster" "main" {
  name = "${var.service_name}-${var.env}-cluster"

  setting {
    name  = "containerInsights"
    value = var.enable_container_insights ? "enabled" : "disabled"
  }
  tags = {
    Name = "${var.service_name}-${var.env}-cluster"
    Env  = var.env
  }
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name       = aws_ecs_cluster.main.name
  capacity_providers = ["FARGATE"]
}
