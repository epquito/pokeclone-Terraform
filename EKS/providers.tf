provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

module "VPC" {
  source = var.aws_VPC_path
  # You can provide input variable values if needed
  
}
