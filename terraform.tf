# Author: Alexandru Raul
# aws-s3-backend/terraform.tf
terraform {
  required_version = "~> 1.14.0" # Specify the minimum required Terraform version here
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0" # Specify the desired version constraint for AWS provider here
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile

}

# Define your AWS resources and configurations below this point
