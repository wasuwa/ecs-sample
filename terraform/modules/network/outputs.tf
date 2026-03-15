output "vpc_id" {
  description = "VPCのID"
  value       = aws_vpc.main.id
}

output "subnet_ids_by_key" {
  description = "キーごとのサブネットID一覧"
  value = {
    for subnet_key in toset([for subnet in values(var.subnets) : subnet.key]) :
    subnet_key => [
      for key, subnet in var.subnets : aws_subnet.main[key].id
      if subnet.key == subnet_key
    ]
  }
}

output "subnet_cidr_blocks_by_key" {
  description = "キーごとのサブネットCIDR一覧"
  value = {
    for subnet_key in toset([for subnet in values(var.subnets) : subnet.key]) :
    subnet_key => [
      for subnet in values(var.subnets) : subnet.cidr_block
      if subnet.key == subnet_key
    ]
  }
}

output "route_table_ids" {
  description = "ルートテーブルIDのマップ"
  value = {
    for key, route_table in aws_route_table.main : key => route_table.id
  }
}
