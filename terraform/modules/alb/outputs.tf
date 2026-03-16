output "security_group_id" {
  description = "ALB用セキュリティグループのID"
  value       = aws_security_group.main.id
}

output "load_balancer_arn" {
  description = "ALBのARN"
  value       = aws_lb.main.arn
}

output "dns_name" {
  description = "ALBのDNS名"
  value       = aws_lb.main.dns_name
}

output "target_group_arn" {
  description = "ALBターゲットグループのARN"
  value       = aws_lb_target_group.main.arn
}
