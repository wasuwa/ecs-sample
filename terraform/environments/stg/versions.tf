terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.36.0"
    }
  }

  required_version = "~> 1.14.7"
}

provider "aws" {
  region = var.region
}
