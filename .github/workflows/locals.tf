locals {

# ------------------------------------------------------------------
  # Deployment Tags
  #
  # This local variable merges the static deployment tags (defined in
  # var.deployment_tags_static) with dynamic build metadata provided
  # during deployment. The additional tags include:
  #   - Deployment ID (build number)
  #   - Deployed By (build author)
  #   - Git Hash (for version traceability)
  #   - Build Job Name (originating Jenkins job name)
  #
  # NOTE:
  #   Any modifications to these tags must follow the internal change
  #   management process via an approved Jira ticket.
  # ------------------------------------------------------------------
 deployment_tags = merge(
    var.deployment_tags_static,
    { "atos:deployment:deployment_id"   = var.tag_build_number,
      "atos:deployment:deployed_by"     = var.tag_build_author,
      "atos:deployment:git_hash"        = var.tag_build_hash,
      "atos:deployment:build_job_name"  = var.tag_build_job_name
     }
  )



}
