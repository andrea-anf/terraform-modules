variable "path" {
  type        = string
  description = "Path to the role"
  default     = null
}

#variable permissions_boundary {
#    type        = string
#    default     = ""
#    description = "Permissions boundary for the role"
#}

variable "role_name" {
  type        = string
  description = "Role name"
}

variable "role_policies" {
  type = list(object(
    {
      name     = string,
      sid      = string,
      effect   = string,
      action   = list(string),
      resource = list(string)
    }
  ))
  description = "Policies informations"
  default     = []
}

variable "role_services" {
  type        = list(string)
  description = "Services linked to the role"
}