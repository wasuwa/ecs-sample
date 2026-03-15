output "security_group_id" {
  description = "ECSサービス用Security GroupのID"
  value       = aws_security_group.main.id
}

output "execution_role_arn" {
  description = "Execution RoleのARN"
  value       = aws_iam_role.execution.arn
}

output "task_role_arn" {
  description = "Task RoleのARN"
  value       = aws_iam_role.task.arn
}

output "log_group_name" {
  description = "CloudWatch Logsのロググループ名"
  value       = aws_cloudwatch_log_group.main.name
}
