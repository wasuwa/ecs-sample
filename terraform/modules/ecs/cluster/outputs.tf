output "cluster_name" {
  description = "クラスター名"
  value       = aws_ecs_cluster.main.name
}

output "cluster_arn" {
  description = "クラスターのARN"
  value       = aws_ecs_cluster.main.arn
}
