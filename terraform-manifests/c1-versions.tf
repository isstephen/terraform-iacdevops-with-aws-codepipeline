terraform {
  required_version = ">=1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.2.1"
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.7.1"
    }
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3"{}
}

provider "aws" {
  region = var.aws_region
  profile = "default"
}

# Create Random Pet Resource
resource "random_pet" "this" {
  length = 2
}
