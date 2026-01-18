#Author: Alexandru Raul
### Variables ###

# Standards
#S3 standard starting name
variable "s3_standard_bucket_name" {
  type        = string
  description = "Standard bucket name"
  default     = "tfstate-prod"
  validation {
    condition     = var.s3_standard_bucket_name == "tfstate-prod"
    error_message = "The variable 's3_standard_bucket_name' must be one of the following: tfstate-prod"
  }
}

# End S3 standard starting name


#AWS region
variable "region" {
  type        = string
  description = "Region"
  validation {
    condition     = var.region == "us-west-2" || var.region == "eu-west-1" || var.region == "eu-central-1" || var.region == "eu-north-1"
    error_message = "The variable 'aws_region' must be one of the following regions: us-west-2, eu-west-1, eu-central-1 or eu-north-1"
  }
}
#End AWS region

#AWS profile
variable "profile" {
  type        = string
  description = "What AWS profile to use"
  validation {
    condition     = var.profile == "punctiq-dev" || var.profile == "punctiq-finops" || var.profile == "punctiq-prod"
    error_message = "The variable 'aws_profile' must be one of the following: punctiq-dev, punctiq-finops, punctiq-prod"
  }
}
#End AWS profile


#Module version
variable "terraform_module_version" {
  type        = string
  description = "Terraform module used to deploy resource"

}
#End AWS region



# END Standards


###### S3 variables ######

#S3 bucket name
variable "s3_bucket_name" {
  type        = string
  description = "Bucket name"
  validation {
    condition     = length(var.s3_bucket_name) <= 40
    error_message = "The total length must not exceed 40 characters."
  }
}
#End S3 bucket name



#S3 bucket versioning
variable "s3_bucket_versioning" {
  type        = string
  description = "Choose if you want to have bucket versioning."
  default     = "Enabled"
  validation {
    condition     = var.s3_bucket_versioning == "Enabled" || var.s3_bucket_versioning == "Disabled"
    error_message = "The variable 's3_bucket_versioning' must be one of the following: Enabled or Disabled"
  }
}
#End S3 bucket versioning




# S3 public access settings
variable "s3_block_public_acls" {
  type        = string
  description = "Whether to block public ACLs"
  default     = true
  validation {
    condition     = var.s3_block_public_acls == "true" || var.s3_block_public_acls == "false"
    error_message = "The variable 'block_public_acls' must be one of the following: true or false"
  }
}
# End S3 public access settings

# S3 block public policies
variable "s3_block_public_policy" {
  type        = string
  description = "Whether to block public policies"
  default     = true
  validation {
    condition     = var.s3_block_public_policy == "true" || var.s3_block_public_policy == "false"
    error_message = "The variable 'block_public_policy' must be one of the following: true or false"
  }
}
# S3 block public policies



# S3 server side encryption
variable "s3_server_side_encryption" {
  type        = string
  description = "S3 server side encryption"
  default     = "AES256"
  validation {
    condition     = var.s3_server_side_encryption == "AES256" || var.s3_server_side_encryption == "aws:kms" || var.s3_server_side_encryption == "aws:kms:dsse"
    error_message = "The variable 's3_server_side_encryption' must be one of the following algorithms: AES256, aws:kms, aws:kms:dsse "
  }
}

# END S3 server side encryption
###### END S3 variables ######


###### DynamoDb table variable ######

#DynamoDB Table Name
variable "dynamo_tbl_name" {
  type        = string
  description = "DynamoDB table name"
  validation {
    condition     = length(var.dynamo_tbl_name) <= 30
    error_message = "The total length must not exceed 20 characters."
  }
}
#End DynamoDB Table Name


#DynamoDB attribute type
variable "dynamo_tbl_attribute_type" {
  type        = string
  description = "DynamoDB table attribute type"
  default     = "S"
  validation {
    condition     = var.dynamo_tbl_attribute_type == "S" || var.dynamo_tbl_attribute_type == "N" || var.dynamo_tbl_attribute_type == "B"
    error_message = "The variable 'dynamo_tbl_attribute_type' must be one of the following: S (string), N(number) or B(binary)"
  }
}
#End DynamoDB attribute type


#DynamoDB hash key
variable "dynamo_tbl_hash_key" {
  type        = string
  description = "Attribute to use as the hash (partition) key"
  default     = "LockID"
  validation {
    condition     = var.dynamo_tbl_hash_key == "LockID"
    error_message = "The variable 'dynamo_tbl_hash_key' must be one of the following: LockID"
  }
}
#End DynamoDB hash key

#DynamoDB billing mode
variable "dynamo_tbl_billing_mode" {
  type        = string
  description = "DynamoDB billing mode"
  default     = "PAY_PER_REQUEST"
  validation {
    condition     = var.dynamo_tbl_billing_mode == "PAY_PER_REQUEST" || var.dynamo_tbl_billing_mode == "PROVISIONED"
    error_message = "The variable 'dynamo_tbl_billing_mode' must be one of the following: PAY_PER_REQUEST or PROVISIONED"
  }
}
#End DynamoDB hash key

#DynamoDB  point in time recovery
variable "dynamo_tbl_point_in_time_recovery" {
  type        = string
  description = "DynamoDB point in time recovery"
  default     = true
  validation {
    condition     = var.dynamo_tbl_point_in_time_recovery == "true" || var.dynamo_tbl_point_in_time_recovery == "false"
    error_message = "The variable 'dynamo_tbl_point_in_time_recovery' must be one of the following: true or false"
  }
}
#End DynamoDB point in time recovery


###### END DynamoDb table variable ######


#Tagging
#Business TAGS
variable "business_tags" {
  description = "Business TAGS"
  type        = map(string)
  validation {
    condition = (
      length(keys(var.business_tags)) == 9 &&
      can(var.business_tags["punctiq:business:project"]) &&
      try(var.business_tags["punctiq:business:project"] == lower(var.business_tags["punctiq:business:project"]), false)
    )
    error_message = "The 'punctiq:business:project' tag is required and must be all-lowercase."
  }

  validation {
    condition = (
      length(keys(var.business_tags)) == 9 &&
      can(var.business_tags["punctiq:business:owner"]) &&
      try(var.business_tags["punctiq:business:owner"] == lower(var.business_tags["punctiq:business:owner"]), false)
    )
    error_message = "The 'punctiq:business:owner' tag is required and must be all-lowercase."
  }

  validation {
    condition = (
      length(keys(var.business_tags)) == 9 &&
      can(var.business_tags["punctiq:business:charge_to_id"]) &&
      try(var.business_tags["punctiq:business:charge_to_id"] == lower(var.business_tags["punctiq:business:charge_to_id"]), false)
    )
    error_message = "The 'punctiq:business:charge_to_id' tag is required and must be all-lowercase."
  }

  validation {
    condition = (
      length(keys(var.business_tags)) == 9 &&
      can(var.business_tags["punctiq:business:businessunit"]) &&
      try(var.business_tags["punctiq:business:businessunit"] == lower(var.business_tags["punctiq:business:businessunit"]), false)
    )
    error_message = "The 'punctiq:business:businessunit' tag is required and must be all-lowercase."
  }

  validation {
    condition = (
      length(keys(var.business_tags)) == 9 &&
      can(var.business_tags["punctiq:business:wbs"]) &&
      try(var.business_tags["punctiq:business:wbs"] == lower(var.business_tags["punctiq:business:wbs"]), false)
    )
    error_message = "The 'punctiq:business:wbs' tag is required and must be all-lowercase."
  }

  validation {
    condition = (
      length(keys(var.business_tags)) == 9 &&
      can(var.business_tags["punctiq:business:stakeholder"]) &&
      try(var.business_tags["punctiq:business:stakeholder"] == lower(var.business_tags["punctiq:business:stakeholder"]), false)
    )
    error_message = "The 'punctiq:business:stakeholder' tag is required and must be all-lowercase."
  }

  validation {
    condition = (
      length(keys(var.business_tags)) == 9 &&
      can(var.business_tags["punctiq:business:impact"]) &&
      try(var.business_tags["punctiq:business:impact"] == lower(var.business_tags["punctiq:business:impact"]), false)
    )
    error_message = "The 'punctiq:business:impact' tag is required and must be all-lowercase."
  }

  validation {
    condition = (
      length(keys(var.business_tags)) == 9 &&
      can(var.business_tags["punctiq:business:dedicated:client_name"]) &&
      try(var.business_tags["punctiq:business:dedicated:client_name"] == lower(var.business_tags["punctiq:business:dedicated:client_name"]), false)
    )
    error_message = "The 'punctiq:business:dedicated:client_name' tag is required and must be all-lowercase."
  }

  validation {
    condition = (
      length(keys(var.business_tags)) == 9 &&
      can(var.business_tags["punctiq:business:dedicated:country"]) &&
      try(var.business_tags["punctiq:business:dedicated:country"] == lower(var.business_tags["punctiq:business:dedicated:country"]), false)
    )
    error_message = "The 'punctiq:business:dedicated:country' tag is required and must be all-lowercase."
  }
}
#End Business TAGS


#Technical TAGS
#S3 technical TAGS
variable "technical_s3_tags" {
  description = "S3 technical TAGS"
  type        = map(string)
  validation {
    condition = (
      length(keys(var.technical_s3_tags)) == 7 &&
      can(var.technical_s3_tags["punctiq:s3:technical:stack"]) &&
      try(var.technical_s3_tags["punctiq:s3:technical:stack"] == lower(var.technical_s3_tags["punctiq:s3:technical:stack"]), false)
    )
    error_message = "The 'punctiq:s3:technical:stack' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.technical_s3_tags)) == 7 &&
      can(var.technical_s3_tags["punctiq:s3:technical:deployment_method"]) &&
      try(var.technical_s3_tags["punctiq:s3:technical:deployment_method"] == lower(var.technical_s3_tags["punctiq:s3:technical:deployment_method"]), false)
    )
    error_message = "The 'punctiq:s3:technical:deployment_method' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.technical_s3_tags)) == 7 &&
      can(var.technical_s3_tags["punctiq:s3:technical:versioning"]) &&
      try(var.technical_s3_tags["punctiq:s3:technical:versioning"] == lower(var.technical_s3_tags["punctiq:s3:technical:versioning"]), false)
    )
    error_message = "The 'punctiq:s3:technical:versioning' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.technical_s3_tags)) == 7 &&
      can(var.technical_s3_tags["punctiq:s3:technical:replication"]) &&
      try(var.technical_s3_tags["punctiq:s3:technical:replication"] == lower(var.technical_s3_tags["punctiq:s3:technical:replication"]), false)
    )
    error_message = "The 'punctiq:s3:technical:replication' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.technical_s3_tags)) == 7 &&
      can(var.technical_s3_tags["punctiq:s3:technical:lifecycle"]) &&
      try(var.technical_s3_tags["punctiq:s3:technical:lifecycle"] == lower(var.technical_s3_tags["punctiq:s3:technical:lifecycle"]), false)
    )
    error_message = "The 'punctiq:s3:technical:lifecycle' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.technical_s3_tags)) == 7 &&
      can(var.technical_s3_tags["punctiq:s3:technical:logging"]) &&
      try(var.technical_s3_tags["punctiq:s3:technical:logging"] == lower(var.technical_s3_tags["punctiq:s3:technical:logging"]), false)
    )
    error_message = "The 'punctiq:s3:technical:logging' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.technical_s3_tags)) == 7 &&
      can(var.technical_s3_tags["punctiq:s3:technical:notification"]) &&
      try(var.technical_s3_tags["punctiq:s3:technical:notification"] == lower(var.technical_s3_tags["punctiq:s3:technical:notification"]), false)
    )
    error_message = "The 'punctiq:s3:technical:notification' tag is required and must be all-lowercase."
  }
}
#End S3 technical TAGS

#DynamoDB table technical TAGS
variable "technical_dynamodbtbl_tags" {
  description = "DynamoDb table technical TAGS"
  type        = map(string)
  validation {
    condition = (
      length(keys(var.technical_dynamodbtbl_tags)) == 7 &&
      can(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:stack"]) &&
      try(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:stack"] == lower(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:stack"]), false)
    )
    error_message = "The 'punctiq:dynamotbl:technical:stack' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.technical_dynamodbtbl_tags)) == 7 &&
      can(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:deployment_method"]) &&
      try(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:deployment_method"] == lower(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:deployment_method"]), false)
    )
    error_message = "The 'punctiq:dynamotbl:technical:deployment_method' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.technical_dynamodbtbl_tags)) == 7 &&
      can(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:versioning"]) &&
      try(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:versioning"] == lower(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:versioning"]), false)
    )
    error_message = "The 'punctiq:dynamotbl:technical:versioning' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.technical_dynamodbtbl_tags)) == 7 &&
      can(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:replication"]) &&
      try(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:replication"] == lower(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:replication"]), false)
    )
    error_message = "The 'punctiq:dynamotbl:technical:replication' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.technical_dynamodbtbl_tags)) == 7 &&
      can(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:lifecycle"]) &&
      try(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:lifecycle"] == lower(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:lifecycle"]), false)
    )
    error_message = "The 'punctiq:dynamotbl:technical:lifecycle' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.technical_dynamodbtbl_tags)) == 7 &&
      can(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:logging"]) &&
      try(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:logging"] == lower(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:logging"]), false)
    )
    error_message = "The 'punctiq:dynamotbl:technical:logging' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.technical_dynamodbtbl_tags)) == 7 &&
      can(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:notification"]) &&
      try(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:notification"] == lower(var.technical_dynamodbtbl_tags["punctiq:dynamotbl:technical:notification"]), false)
    )
    error_message = "The 'punctiq:dynamotbl:technical:notification' tag is required and must be all-lowercase."
  }

}
#End DynamoDB table technical TAGS
#End technical TAGS


#Security TAGS
#S3 security TAGS
variable "security_s3_tags" {
  description = "S3 security TAGS"
  type        = map(string)
  validation {
    condition = (
      length(keys(var.security_s3_tags)) == 6 &&
      can(var.security_s3_tags["punctiq:s3:security:compliance"]) &&
      try(var.security_s3_tags["punctiq:s3:security:compliance"] == lower(var.security_s3_tags["punctiq:s3:security:compliance"]), false)
    )
    error_message = "The 'punctiq:s3:security:compliance' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.security_s3_tags)) == 6 &&
      can(var.security_s3_tags["punctiq:s3:security:classification"]) &&
      try(var.security_s3_tags["punctiq:s3:security:classification"] == lower(var.security_s3_tags["punctiq:s3:security:classification"]), false)
    )
    error_message = "The 'punctiq:s3:security:classification' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.security_s3_tags)) == 6 &&
      can(var.security_s3_tags["punctiq:s3:security:encryption"]) &&
      try(var.security_s3_tags["punctiq:s3:security:encryption"] == lower(var.security_s3_tags["punctiq:s3:security:encryption"]), false)
    )
    error_message = "The 'punctiq:s3:security:encryption' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.security_s3_tags)) == 6 &&
      can(var.security_s3_tags["punctiq:s3:security:level"]) &&
      try(var.security_s3_tags["punctiq:s3:security:level"] == lower(var.security_s3_tags["punctiq:s3:security:level"]), false)
    )
    error_message = "The 'punctiq:s3:security:level' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.security_s3_tags)) == 6 &&
      can(var.security_s3_tags["punctiq:s3:security:incident_response"]) &&
      try(var.security_s3_tags["punctiq:s3:security:incident_response"] == lower(var.security_s3_tags["punctiq:s3:security:incident_response"]), false)
    )
    error_message = "The 'punctiq:s3:security:incident_response' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.security_s3_tags)) == 6 &&
      can(var.security_s3_tags["punctiq:s3:security:access_control"]) &&
      try(var.security_s3_tags["punctiq:s3:security:access_control"] == lower(var.security_s3_tags["punctiq:s3:security:access_control"]), false)
    )
    error_message = "The 'punctiq:s3:security:access_control' tag is required and must be all-lowercase."
  }

}
#End S3 Security TAGS

variable "security_dynamotbl_tags" {
  description = "DynamoDB tables security TAGS"
  type        = map(string)
  validation {
    condition = (
      length(keys(var.security_dynamotbl_tags)) == 6 &&
      can(var.security_dynamotbl_tags["punctiq:dynamotbl:security:compliance"]) &&
      try(var.security_dynamotbl_tags["punctiq:dynamotbl:security:compliance"] == lower(var.security_dynamotbl_tags["punctiq:dynamotbl:security:compliance"]), false)
    )
    error_message = "The 'punctiq:dynamotbl:security:compliance' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.security_dynamotbl_tags)) == 6 &&
      can(var.security_dynamotbl_tags["punctiq:dynamotbl:security:classification"]) &&
      try(var.security_dynamotbl_tags["punctiq:dynamotbl:security:classification"] == lower(var.security_dynamotbl_tags["punctiq:dynamotbl:security:classification"]), false)
    )
    error_message = "The 'punctiq:dynamotbl:security:classification' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.security_dynamotbl_tags)) == 6 &&
      can(var.security_dynamotbl_tags["punctiq:dynamotbl:security:encryption"]) &&
      try(var.security_dynamotbl_tags["punctiq:dynamotbl:security:encryption"] == lower(var.security_dynamotbl_tags["punctiq:dynamotbl:security:encryption"]), false)
    )
    error_message = "The 'punctiq:dynamotbl:security:encryption' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.security_dynamotbl_tags)) == 6 &&
      can(var.security_dynamotbl_tags["punctiq:dynamotbl:security:level"]) &&
      try(var.security_dynamotbl_tags["punctiq:dynamotbl:security:level"] == lower(var.security_dynamotbl_tags["punctiq:dynamotbl:security:level"]), false)
    )
    error_message = "The 'punctiq:dynamotbl:security:level' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.security_dynamotbl_tags)) == 6 &&
      can(var.security_dynamotbl_tags["punctiq:dynamotbl:security:incident_response"]) &&
      try(var.security_dynamotbl_tags["punctiq:dynamotbl:security:incident_response"] == lower(var.security_dynamotbl_tags["punctiq:dynamotbl:security:incident_response"]), false)
    )
    error_message = "The 'punctiq:dynamotbl:security:incident_response' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.security_dynamotbl_tags)) == 6 &&
      can(var.security_dynamotbl_tags["punctiq:dynamotbl:security:access_control"]) &&
      try(var.security_dynamotbl_tags["punctiq:dynamotbl:security:access_control"] == lower(var.security_dynamotbl_tags["punctiq:dynamotbl:security:access_control"]), false)
    )
    error_message = "The 'punctiq:dynamotbl:security:access_control' tag is required and must be all-lowercase."
  }
}
#End DynamoDB table Security TAGS
#End security TAGS

#Billing TAGS
variable "billing_tags" {
  description = "Billing and cost allocation TAGS"
  type        = map(string)
  validation {
    condition = (
      length(keys(var.billing_tags)) == 4 &&
      can(var.billing_tags["punctiq:billing:credit"]) &&
      try(var.billing_tags["punctiq:billing:credit"] == lower(var.billing_tags["punctiq:billing:credit"]), false)
    )
    error_message = "The 'punctiq:billing:credit' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.billing_tags)) == 4 &&
      can(var.billing_tags["punctiq:billing:account_name"]) &&
      try(var.billing_tags["punctiq:billing:account_name"] == lower(var.billing_tags["punctiq:billing:account_name"]), false)
    )
    error_message = "The 'punctiq:billing:account_name' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.billing_tags)) == 4 &&
      can(var.billing_tags["punctiq:billing:contact_name"]) &&
      try(var.billing_tags["punctiq:billing:contact_name"] == lower(var.billing_tags["punctiq:billing:contact_name"]), false)
    )
    error_message = "The 'punctiq:billing:contact_name' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.billing_tags)) == 4 &&
      can(var.billing_tags["punctiq:billing:contact_email"]) &&
      try(var.billing_tags["punctiq:billing:contact_email"] == lower(var.billing_tags["punctiq:billing:contact_email"]), false)
    )
    error_message = "The 'punctiq:billing:contact_email' tag is required and must be all-lowercase."
  }
}
#End billing TAGS

#Backup TAGS
variable "backup_s3_tags" {
  description = "Backup and cost allocation TAGS for S3 resource"
  type        = map(string)
  validation {
    condition = (
      length(keys(var.backup_s3_tags)) == 5 &&
      can(var.backup_s3_tags["punctiq:backup:s3"]) &&
      try(var.backup_s3_tags["punctiq:backup:s3"] == lower(var.backup_s3_tags["punctiq:backup:s3"]), false)
    )
    error_message = "The 'punctiq:backup:s3' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.backup_s3_tags)) == 5 &&
      can(var.backup_s3_tags["punctiq:backup:charge_to_id"]) &&
      try(var.backup_s3_tags["punctiq:backup:charge_to_id"] == lower(var.backup_s3_tags["punctiq:backup:charge_to_id"]), false)
    )
    error_message = "The 'punctiq:backup:charge_to_id' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.backup_s3_tags)) == 5 &&
      can(var.backup_s3_tags["punctiq:backup:frequency"]) &&
      try(var.backup_s3_tags["punctiq:backup:frequency"] == lower(var.backup_s3_tags["punctiq:backup:frequency"]), false)
    )
    error_message = "The 'punctiq:backup:frequency' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.backup_s3_tags)) == 5 &&
      can(var.backup_s3_tags["punctiq:backup:owner"]) &&
      try(var.backup_s3_tags["punctiq:backup:owner"] == lower(var.backup_s3_tags["punctiq:backup:owner"]), false)
    )
    error_message = "The 'punctiq:backup:owner' tag is required and must be all-lowercase."
  }
  validation {
    condition = (
      length(keys(var.backup_s3_tags)) == 5 &&
      can(var.backup_s3_tags["punctiq:backup:data_classification"]) &&
      try(var.backup_s3_tags["punctiq:backup:data_classification"] == lower(var.backup_s3_tags["punctiq:backup:data_classification"]), false)
    )
    error_message = "The 'punctiq:backup:data_classification' tag is required and must be all-lowercase."
  }
}
# End Backup TAGS
#End
