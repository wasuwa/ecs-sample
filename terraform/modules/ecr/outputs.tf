output "repository_arn" {
  description = "ECRリポジトリのARN"
  value       = aws_ecr_repository.main.arn
}

output "repository_url" {
  description = "ECRリポジトリのURL"
  value       = aws_ecr_repository.main.repository_url
}
