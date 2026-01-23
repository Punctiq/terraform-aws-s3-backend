# ==========================================================
# terraform-aws-s3-backend/variables_standards.tf
# Author: Alexandru Raul
# ==========================================================

########################
# Standards
########################

#variable "s3_standard_bucket_name" {
#  type        = string
#  description = "Standard bucket name"
#  default     = "tfstate-prod"

#  validation {
#    condition     = var.s3_standard_bucket_name == "tfstate-prod"
#    error_message = "The variable 's3_standard_bucket_name' must be one of the following: tfstate-prod"
#  }
#}

variable "region" {
  type        = string
  description = "Region"

  validation {
    condition     = var.region == "us-west-2" || var.region == "eu-west-1" || var.region == "eu-central-1" || var.region == "eu-north-1"
    error_message = "The variable 'aws_region' must be one of the following regions: us-west-2, eu-west-1, eu-central-1 or eu-north-1"
  }
}

variable "profile" {
  type        = string
  description = "What AWS profile to use"

  validation {
    condition     = var.profile == "punctiq-dev" || var.profile == "punctiq-finops" || var.profile == "punctiq-prod"
    error_message = "The variable 'aws_profile' must be one of the following: punctiq-dev, punctiq-finops, punctiq-prod"
  }
}

variable "terraform_module_version" {
  type        = string
  description = "Terraform module used to deploy resource"
}
