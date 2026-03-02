# ────────────────────────────────────────────────────────────────
# Outputs – very useful for module consumers
# ────────────────────────────────────────────────────────────────
output "s3_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  value       = aws_s3_bucket.this.bucket
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.this.arn
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB lock table"
  value       = aws_dynamodb_table.this.name
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB lock table"
  value       = aws_dynamodb_table.this.arn
}

output "backend_config_example" {
  description = "Example backend configuration block"
  value       = <<EOT
terraform {
  backend "s3" {
    bucket         = "${aws_s3_bucket.this.bucket}"
    key            = "path/to/my/terraform.tfstate"
    region         = "${var.region}"
    dynamodb_table = "${aws_dynamodb_table.this.name}"
    encrypt        = true
  }
}
EOT
}