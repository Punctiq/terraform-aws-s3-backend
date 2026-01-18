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
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | ~> 1.14.0 |
| <a name="requirement_aws"></a> [aws](#requirement_aws) | >= 3.0.0 |
| <a name="requirement_github"></a> [github](#requirement_github) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider_aws) | >= 3.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.terraform_tfstate_lock](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_s3_bucket.terraform_state_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.terraform_state_bucket_disable_public_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.terraform_tfstate_bucket_encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.terraform_state_bucket_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_s3_tags"></a> [backup_s3_tags](#input_backup_s3_tags) | Backup and cost allocation TAGS for S3 resource | `map(string)` | n/a | yes |
| <a name="input_billing_tags"></a> [billing_tags](#input_billing_tags) | Billing and cost allocation TAGS | `map(string)` | n/a | yes |
| <a name="input_business_tags"></a> [business_tags](#input_business_tags) | Business TAGS | `map(string)` | n/a | yes |
| <a name="input_dynamo_tbl_attribute_type"></a> [dynamo_tbl_attribute_type](#input_dynamo_tbl_attribute_type) | DynamoDB table attribute type | `string` | `"S"` | no |
| <a name="input_dynamo_tbl_billing_mode"></a> [dynamo_tbl_billing_mode](#input_dynamo_tbl_billing_mode) | DynamoDB billing mode | `string` | `"PAY_PER_REQUEST"` | no |
| <a name="input_dynamo_tbl_hash_key"></a> [dynamo_tbl_hash_key](#input_dynamo_tbl_hash_key) | Attribute to use as the hash (partition) key | `string` | `"LockID"` | no |
| <a name="input_dynamo_tbl_name"></a> [dynamo_tbl_name](#input_dynamo_tbl_name) | DynamoDB table name | `string` | n/a | yes |
| <a name="input_dynamo_tbl_point_in_time_recovery"></a> [dynamo_tbl_point_in_time_recovery](#input_dynamo_tbl_point_in_time_recovery) | DynamoDB point in time recovery | `string` | `true` | no |
| <a name="input_profile"></a> [profile](#input_profile) | What AWS profile to use | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input_region) | Region | `string` | n/a | yes |
| <a name="input_s3_block_public_acls"></a> [s3_block_public_acls](#input_s3_block_public_acls) | Whether to block public ACLs | `string` | `true` | no |
| <a name="input_s3_block_public_policy"></a> [s3_block_public_policy](#input_s3_block_public_policy) | Whether to block public policies | `string` | `true` | no |
| <a name="input_s3_bucket_name"></a> [s3_bucket_name](#input_s3_bucket_name) | Bucket name | `string` | n/a | yes |
| <a name="input_s3_bucket_versioning"></a> [s3_bucket_versioning](#input_s3_bucket_versioning) | Choose if you want to have bucket versioning. | `string` | `"Enabled"` | no |
| <a name="input_s3_server_side_encryption"></a> [s3_server_side_encryption](#input_s3_server_side_encryption) | S3 server side encryption | `string` | `"AES256"` | no |
| <a name="input_s3_standard_bucket_name"></a> [s3_standard_bucket_name](#input_s3_standard_bucket_name) | Standard bucket name | `string` | `"tfstate-prod"` | no |
| <a name="input_security_dynamotbl_tags"></a> [security_dynamotbl_tags](#input_security_dynamotbl_tags) | DynamoDB tables security TAGS | `map(string)` | n/a | yes |
| <a name="input_security_s3_tags"></a> [security_s3_tags](#input_security_s3_tags) | S3 security TAGS | `map(string)` | n/a | yes |
| <a name="input_technical_dynamodbtbl_tags"></a> [technical_dynamodbtbl_tags](#input_technical_dynamodbtbl_tags) | DynamoDb table technical TAGS | `map(string)` | n/a | yes |
| <a name="input_technical_s3_tags"></a> [technical_s3_tags](#input_technical_s3_tags) | S3 technical TAGS | `map(string)` | n/a | yes |
| <a name="input_terraform_module_version"></a> [terraform_module_version](#input_terraform_module_version) | Terraform module used to deploy resource | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_terraform_state_bucket_arn"></a> [terraform_state_bucket_arn](#output_terraform_state_bucket_arn) | ARN of the S3 bucket used for Terraform state |
| <a name="output_terraform_state_bucket_name"></a> [terraform_state_bucket_name](#output_terraform_state_bucket_name) | Terraform TF state S3 bucket name |
| <a name="output_terraform_tfstate_lock_table_arn"></a> [terraform_tfstate_lock_table_arn](#output_terraform_tfstate_lock_table_arn) | DynamoDB table ARN used for Terraform state locking |
| <a name="output_terraform_tfstate_lock_table_name"></a> [terraform_tfstate_lock_table_name](#output_terraform_tfstate_lock_table_name) | DynamoDB table name used for Terraform state locking |
<!-- END_TF_DOCS -->
