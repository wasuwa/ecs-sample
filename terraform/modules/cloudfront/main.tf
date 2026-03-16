locals {
  resource_name = "${var.service_name}-${var.env}"
  origin_id     = "${local.resource_name}-alb-origin"
}

resource "aws_cloudfront_vpc_origin" "main" {
  vpc_origin_endpoint_config {
    name                   = "${local.resource_name}-vpc-origin"
    arn                    = var.origin_arn
    http_port              = 80
    https_port             = 443
    origin_protocol_policy = "http-only"

    origin_ssl_protocols {
      quantity = 1
      items    = ["TLSv1.2"]
    }
  }
}

resource "aws_cloudfront_distribution" "main" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${local.resource_name}-cloudfront"
  price_class         = "PriceClass_200"
  http_version        = "http2"
  wait_for_deployment = true

  origin {
    domain_name = var.origin_domain_name
    origin_id   = local.origin_id

    vpc_origin_config {
      vpc_origin_id = aws_cloudfront_vpc_origin.main.id
    }
  }

  default_cache_behavior {
    target_origin_id       = local.origin_id
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    compress               = true
    # AWS managed-CachingDisabled
    cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    # AWS managed-AllViewerExceptHostHeader
    origin_request_policy_id = "b689b0a8-53d0-40ab-baf2-68738e2966ac"
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["JP"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    minimum_protocol_version       = "TLSv1"
  }

  tags = {
    Name = "${local.resource_name}-cloudfront"
    Env  = var.env
  }
}
