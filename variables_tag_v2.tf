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