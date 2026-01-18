# Author: Alexandru Raul
# aws-s3-backend/outputs.tf

# Export the bucket name as an output variable
output "terraform_state_bucket_name" {
  description = "Terraform TF state S3 bucket name"
  value       = aws_s3_bucket.terraform_state_bucket.id
}

# DynamoDB - Terraform state lock table name
output "terraform_tfstate_lock_table_name" {
  description = "DynamoDB table name used for Terraform state locking"
  value       = aws_dynamodb_table.terraform_tfstate_lock.name
}

# DynamoDB - Terraform state lock table ARN (useful for IAM policies)
output "terraform_tfstate_lock_table_arn" {
  description = "DynamoDB table ARN used for Terraform state locking"
  value       = aws_dynamodb_table.terraform_tfstate_lock.arn
}
# S3 Bucket ARN
output "terraform_state_bucket_arn" {
  description = "ARN of the S3 bucket used for Terraform state"
  value       = aws_s3_bucket.terraform_state_bucket.arn
}