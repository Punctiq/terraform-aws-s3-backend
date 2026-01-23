# Author: Alexandru Raul
# aws-s3-backend/main.tf
# Description: This module creates an S3 bucket and DynamoDB table for Terraform backend state management


#Create the S3 bucket for Terraform TF state file
resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "punctiq-${var.s3_bucket_name}-${var.region}"

  #Prevent bucket deletion
  lifecycle {
    prevent_destroy = false
  }
  #End

  #Tag resources
  tags = merge(
    var.business_tags,     # Business TAGS
    var.technical_s3_tags, # Technical TAGS
    var.security_s3_tags,  # Security TAGS
    var.billing_tags,      # Billing TAGS
    var.backup_s3_tags,    # Backup S3 TAGS
    #Individual tags
    {
      "Name"                     = "punctiq-${var.s3_bucket_name}-${var.region}"
      "CreationDate"             = formatdate("YYYY-MM-DD hh:mm:ss ZZZ", timestamp())
      "Terraform_Module_Version" = var.terraform_module_version
    }
    #End Individual tags
  )
  #End Backup Tags
  #End Create the S3 bucket for Terraform TF state file
}

#We need versioning
resource "aws_s3_bucket_versioning" "terraform_state_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  versioning_configuration {
    status = var.s3_bucket_versioning
  }
}
#End We need versioning

#Disable public access to S3 bucket
resource "aws_s3_bucket_public_access_block" "terraform_state_bucket_disable_public_access" {
  bucket              = aws_s3_bucket.terraform_state_bucket.id
  block_public_acls   = var.s3_block_public_acls
  block_public_policy = var.s3_block_public_policy
}
#End Disable public access to S3 bucket


#Setup encryption on the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_tfstate_bucket_encryption" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.s3_server_side_encryption
    }
  }
}
#End Setup encryption on the S3 bucket

#Create DynamoDB table for Terraform TF state file
resource "aws_dynamodb_table" "terraform_tfstate_lock" {
  hash_key     = var.dynamo_tbl_hash_key
  name         = var.dynamo_tbl_name
  billing_mode = var.dynamo_tbl_billing_mode

  attribute {
    name = var.dynamo_tbl_hash_key
    type = var.dynamo_tbl_attribute_type
  }
  point_in_time_recovery {
    enabled = var.dynamo_tbl_point_in_time_recovery
  }

  #Tag resources
  tags = merge(
    var.business_tags,              #  Business TAGS
    var.technical_dynamodbtbl_tags, # Technical TAGS
    var.security_dynamotbl_tags,    # Security TAGS
    var.billing_tags,               # Billing TAGS
    #Individual tags
    {
      "Name"                     = "punctiq-${var.s3_bucket_name}-${var.region}-dynamodb-tfstate-lock"
      "CreationDate"             = formatdate("YYYY-MM-DD hh:mm:ss ZZZ", timestamp())
      "Terraform_Module_Version" = var.terraform_module_version
    }
    #End Individual tags
  )
  #End Backup Tags

}
#End Create DynamoDB table for Terraform TF state file
