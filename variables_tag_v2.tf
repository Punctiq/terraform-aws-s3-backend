variable "business_cost_tags" {
  description = "Business / cost allocation tags"
  type        = map(string)
  default     = {}
}

variable "client_tags" {
  description = "Client/context tags"
  type        = map(string)
  default     = {}
}

variable "extra_tags" {
  description = "Extra tags merged last"
  type        = map(string)
  default     = {}
}

########################
# Tags - Deployment (Jenkins)
########################

variable "deployment_tags_static" {
  description = "AWS deployment static tags"
  type        = map(string)
}

variable "tag_build_number" {
  description = "Build number, taken from Jenkins"
  type        = string
  default     = ""
}

variable "tag_build_author" {
  description = "Deployment author, taken from Jenkins"
  type        = string
  default     = ""
}

variable "tag_build_hash" {
  description = "GIT hash, taken from Jenkins"
  type        = string
  default     = ""
}

variable "tag_build_job_name" {
  description = "Job name, taken from Jenkins"
  type        = string
  default     = ""
}