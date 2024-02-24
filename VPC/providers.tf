provider "aws" {
    region = "us-east-1"
    profile = "east1-user"
  
}
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
    }
  }
}

