# ==========================================================
# locals.tf - Logica de tagging (versiune light & sustenabilă)
# ==========================================================

locals {
  # ------------------------------------------------------------------
  # Deployment Tags – blocul tău original, 100% neatins
  # ------------------------------------------------------------------
  deployment_tags = merge(
    var.deployment_tags_static,
    { 
      "punctiq:deployment:deployment_id"   = var.tag_build_number,
      "punctiq:deployment:deployed_by"     = var.tag_build_author,
      "punctiq:deployment:git_hash"        = var.tag_build_hash,
      "punctiq:deployment:build_job_name"  = var.tag_build_job_name,
      "punctiq:creationdate"               = time_static.creation.rfc3339, # immutable creation timestamp
      "punctiq:lastupdated"                = formatdate("YYYY-MM-DD hh:mm:ss ZZZ", timestamp()),
    }
  )

  # ────────────────────────────────────────────────────────────────
  # Business & Cost Allocation Tags – esențiale pentru FinOps
  # ────────────────────────────────────────────────────────────────
  business_cost_tags = merge(
    var.business_cost_tags,
    {
      "punctiq:project"      = coalesce(var.business_cost_tags["punctiq:project"],      "finops-internal"),
      "punctiq:owner"        = coalesce(var.business_cost_tags["punctiq:owner"],        "finops-team@punctiq"),
      "punctiq:costcenter" = coalesce(var.business_cost_tags["punctiq:costcenter"], "punctiq-finops-tools")
    }
  )

  # ────────────────────────────────────────────────────────────────
  # Client Context Tags – minim necesar pentru agregare multi-client
  # ────────────────────────────────────────────────────────────────
  client_context_tags = merge(
    var.client_tags,
    {
      "punctiq:client_slug" = coalesce(var.client_tags["punctiq:client_slug"], "unknown-client")
    }
  )

  # ────────────────────────────────────────────────────────────────
  # Common Tags – se aplică pe S3 bucket și DynamoDB table
  # ────────────────────────────────────────────────────────────────
  common_tags = merge(
    # Sistem nou light
    local.business_cost_tags,
    local.client_context_tags,

    # Deployment tags tale
    local.deployment_tags,

    # Tag-urile individuale – exact cum le aveai în modul
    {
      
      "punctiq:terraform_module_version" = var.terraform_module_version,

      # Adiționale light utile (nu afectează Name-ul existent)
      "punctiq:region"                   = var.region,
      "punctiq:managedby"                = "terraform",
      "punctiq:purpose"                  = "terraform-state-backend",
      "punctiq:service"                  = "tf-backend",
      "punctiq:environment"              = "tooling",
      "punctiq:department"               = "finops",
      "punctiq:product"                  = "finops-platform",
      "punctiq:businessunit"             = "internal",
      "punctiq:tagging:version"          = "v2-light-2026"
    },

    var.extra_tags
  )

  # ────────────────────────────────────────────────────────────────
  # Tag specific pentru S3 bucket – păstrăm logica ta existentă
  # ────────────────────────────────────────────────────────────────
  s3_bucket_tags = merge(
    local.common_tags,
    {
      "Name" = "punctiq-${var.s3_bucket_name}-${var.region}"
    }
  )

  # ────────────────────────────────────────────────────────────────
  # Tag specific pentru DynamoDB table – păstrăm logica ta existentă
  # ────────────────────────────────────────────────────────────────
  dynamodb_tags = merge(
    local.common_tags,
    {
      "Name" = "punctiq-${var.s3_bucket_name}-${var.region}-dynamodb-tfstate-lock"
    }
  )
}