resource "aws_security_group" "main" {
  name        = "${var.service_name}-${var.env}-service-sg"
  description = "Security group for ECS service tasks"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow traffic from ALB"
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.service_name}-${var.env}-service-sg"
    Env  = var.env
  }
}

data "aws_iam_policy_document" "main" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# タスク実行ロール
resource "aws_iam_role" "execution" {
  name               = "${var.service_name}-${var.env}-execution-role"
  assume_role_policy = data.aws_iam_policy_document.main.json

  tags = {
    Name = "${var.service_name}-${var.env}-execution-role"
    Env  = var.env
  }
}

resource "aws_iam_role_policy_attachment" "execution_default" {
  role       = aws_iam_role.execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# タスクロール
resource "aws_iam_role" "task" {
  name               = "${var.service_name}-${var.env}-task-role"
  assume_role_policy = data.aws_iam_policy_document.main.json

  tags = {
    Name = "${var.service_name}-${var.env}-task-role"
    Env  = var.env
  }
}

resource "aws_cloudwatch_log_group" "main" {
  name              = "/ecs/${var.service_name}-${var.env}"
  retention_in_days = 30

  tags = {
    Name = "/ecs/${var.service_name}-${var.env}"
    Env  = var.env
  }
}
