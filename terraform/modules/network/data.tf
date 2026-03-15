data "aws_availability_zones" "main" {
  state = "available"
  # 廃止されたap-northeast-1bを除外
  exclude_names = ["ap-northeast-1b"]
}
