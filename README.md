# aws-s3-backend (Terraform module)
Author: Alexandru Raul

This module is intended for bootstrapping Terraform backends and is usually deployed once per environment.

---
## English (EN)

### Overview
This module bootstraps a Terraform remote backend by creating:
- An S3 bucket for Terraform state (tfstate)
- A DynamoDB table for state locking

It is intended to be used once per environment (e.g., prod/finops/dev), then reused by other Terraform stacks via `backend "s3"`.

### What it creates (high level)
- S3 bucket: versioning enabled, public access blocked, server-side encryption enabled
- DynamoDB table: used for Terraform state locking

### How to use (module call example)
```hcl
module "tf_backend" {
  source = "./aws-s3-backend"

  region  = "eu-central-1"
  profile = "profile"

  terraform_module_version = "1.0.0"
  s3_standard_bucket_name  = "tfstate-prod"
  s3_bucket_name           = "core-backend"

  dynamo_tbl_name = "punctiq-tf-lock"

  # tags
  business_tags               = var.business_tags
  technical_s3_tags           = var.technical_s3_tags
  technical_dynamodbtbl_tags  = var.technical_dynamodbtbl_tags
  security_s3_tags            = var.security_s3_tags
  security_dynamotbl_tags     = var.security_dynamotbl_tags
  billing_tags                = var.billing_tags
  backup_s3_tags              = var.backup_s3_tags
}
```
## Deploy steps

```bash
terraform init
terraform plan
terraform apply
```

## Using the created backend in another Terraform project

Configure backend in the ROOT project (not inside this module):

```hcl
terraform {
  backend "s3" {
    bucket         = "<OUTPUT: terraform_state_bucket_name>"
    key            = "terraform.tfstate"
    region         = "<REGION>"
    dynamodb_table = "<OUTPUT: terraform_tfstate_lock_table_name>"
    encrypt        = true
  }
}
```

## IAM / Security notes

A deployment identity needs permissions to:

- Create/configure the S3 bucket (versioning, encryption, public access block, tags)
- Create/configure the DynamoDB table (PITR, tags)
- Use the backend (S3 read/write objects + DynamoDB lock operations)
- Keep the deployment identity scoped to your bucket/table naming convention.

## Naming convention

**S3 bucket name:**
```hcl
punctiq-${s3_standard_bucket_name}-${s3_bucket_name}-${region}
```

## Tags

This module expects standardized tags. Values should be lowercase where validations require it.

<!-- BEGIN_TF_DOCS -->

<!-- END_TF_DOCS -->
