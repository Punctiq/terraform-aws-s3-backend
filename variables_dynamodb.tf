# ==========================================================
# terraform-aws-s3-backend/variables_dynamodb.tf 
# Author: Alexandru Raul
# ==========================================================

########################
# DynamoDB variables
########################

variable "dynamo_tbl_name" {
  type        = string
  description = "DynamoDB table name"

  validation {
    condition     = length(var.dynamo_tbl_name) <= 30
    error_message = "The total length must not exceed 20 characters."
  }
}

variable "dynamo_tbl_attribute_type" {
  type        = string
  description = "DynamoDB table attribute type"
  default     = "S"

  validation {
    condition     = var.dynamo_tbl_attribute_type == "S" || var.dynamo_tbl_attribute_type == "N" || var.dynamo_tbl_attribute_type == "B"
    error_message = "The variable 'dynamo_tbl_attribute_type' must be one of the following: S (string), N(number) or B(binary)"
  }
}

variable "dynamo_tbl_hash_key" {
  type        = string
  description = "Attribute to use as the hash (partition) key"
  default     = "LockID"

  validation {
    condition     = var.dynamo_tbl_hash_key == "LockID"
    error_message = "The variable 'dynamo_tbl_hash_key' must be one of the following: LockID"
  }
}

variable "dynamo_tbl_billing_mode" {
  type        = string
  description = "DynamoDB billing mode"
  default     = "PAY_PER_REQUEST"

  validation {
    condition     = var.dynamo_tbl_billing_mode == "PAY_PER_REQUEST" || var.dynamo_tbl_billing_mode == "PROVISIONED"
    error_message = "The variable 'dynamo_tbl_billing_mode' must be one of the following: PAY_PER_REQUEST or PROVISIONED"
  }
}

variable "dynamo_tbl_point_in_time_recovery" {
  type        = string
  description = "DynamoDB point in time recovery"
  default     = true

  validation {
    condition     = var.dynamo_tbl_point_in_time_recovery == "true" || var.dynamo_tbl_point_in_time_recovery == "false"
    error_message = "The variable 'dynamo_tbl_point_in_time_recovery' must be one of the following: true or false"
  }
}
