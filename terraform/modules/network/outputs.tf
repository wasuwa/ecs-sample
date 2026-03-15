output "vpc_id" {
  description = "VPCのID"
  value       = aws_vpc.main.id
}

output "private_subnet_ids" {
  description = "プライベートサブネットのID一覧"
  value       = values(aws_subnet.main)[*].id
}
