# ==========================================================
# terraform-aws-s3-backend/variables_s3.tf
# Author: Alexandru Raul
# ==========================================================

########################
# S3 variables
########################

variable "s3_bucket_name" {
  type        = string
  description = "Bucket name"

  validation {
    condition     = length(var.s3_bucket_name) <= 40
    error_message = "The total length must not exceed 40 characters."
  }
}

variable "s3_bucket_versioning" {
  type        = string
  description = "Choose if you want to have bucket versioning."
  default     = "Enabled"

  validation {
    condition     = var.s3_bucket_versioning == "Enabled" || var.s3_bucket_versioning == "Disabled"
    error_message = "The variable 's3_bucket_versioning' must be one of the following: Enabled or Disabled"
  }
}

variable "s3_block_public_acls" {
  type        = string
  description = "Whether to block public ACLs"
  default     = true

  validation {
    condition     = var.s3_block_public_acls == "true" || var.s3_block_public_acls == "false"
    error_message = "The variable 'block_public_acls' must be one of the following: true or false"
  }
}

variable "s3_block_public_policy" {
  type        = string
  description = "Whether to block public policies"
  default     = true

  validation {
    condition     = var.s3_block_public_policy == "true" || var.s3_block_public_policy == "false"
    error_message = "The variable 'block_public_policy' must be one of the following: true or false"
  }
}

variable "s3_server_side_encryption" {
  type        = string
  description = "S3 server side encryption"
  default     = "AES256"

  validation {
    condition     = var.s3_server_side_encryption == "AES256" || var.s3_server_side_encryption == "aws:kms" || var.s3_server_side_encryption == "aws:kms:dsse"
    error_message = "The variable 's3_server_side_encryption' must be one of the following algorithms: AES256, aws:kms, aws:kms:dsse "
  }
}
