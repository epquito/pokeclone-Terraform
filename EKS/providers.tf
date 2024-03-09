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
  source = "/home/epquito/docker_lessons/kubernetes_lesson/capstone/terraform-pokeclone/VPC"  
  # You can provide input variable values if needed
  
}
