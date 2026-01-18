# ==========================================================
# terraform-aws-s3-backend/variables_tags.tf
# Author: Alexandru Raul
# ==========================================================

########################
# Tagging variables
########################

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
