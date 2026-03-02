# Author: Alexandru Raul
# aws-s3-backend/main.tf
# Description: Creates secure S3 + DynamoDB Terraform remote state backend
#              with FinOps tagging, protection and best practices (2026)

resource "time_static" "creation" {
  # Fixed timestamp at initial creation → used in tags
}

# ────────────────────────────────────────────────────────────────
# S3 Bucket
# ────────────────────────────────────────────────────────────────
resource "aws_s3_bucket" "this" {
  bucket = "punctiq-${var.s3_bucket_name}-${var.region}"

  tags = local.s3_bucket_tags

  lifecycle {
    prevent_destroy = var.prevent_destroy  # default true in variables.tf
    ignore_changes  = [tags["punctiq:lastupdated"]]
  }
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.s3_server_side_encryption
      kms_master_key_id = var.s3_server_side_encryption == "aws:kms" ? var.kms_key_id : null
    }
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.s3_bucket_versioning  # "Enabled" recommended
  }

  depends_on = [
    aws_s3_bucket_ownership_controls.this,
    aws_s3_bucket_public_access_block.this,
    aws_s3_bucket_server_side_encryption_configuration.this
  ]
}