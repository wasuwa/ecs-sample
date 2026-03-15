output "security_group_id" {
  description = "ALB用セキュリティグループのID"
  value       = aws_security_group.main.id
}

output "target_group_arn" {
  description = "ALBターゲットグループのARN"
  value       = aws_lb_target_group.main.arn
}
