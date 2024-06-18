terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.15.0"
    }
  }
}

provider "aws" {
  region = var.AWS_REGION
  default_tags {
    tags = {
      managed_by = "terraform"
    }
  }
}
data "aws_availability_zones" "available" {}

data "aws_region" "current" {}
