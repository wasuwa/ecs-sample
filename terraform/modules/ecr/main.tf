locals {
  repository_name = "${var.service_name}-${var.env}-${var.service_role_name}"

  default_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep only the latest 3 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 3
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_repository" "main" {
  name                 = local.repository_name
  image_tag_mutability = var.image_tag_mutability

  tags = {
    Name = local.repository_name
    Env  = var.env
  }
}

resource "aws_ecr_lifecycle_policy" "main" {
  repository = aws_ecr_repository.main.name
  policy     = coalesce(var.lifecycle_policy, local.default_lifecycle_policy)
}
