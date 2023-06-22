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

variable "user_name" {
  type        = string
  description = "User name"
}

variable "name_prefix" {
  type        = string
  description = "Uer name prefix"
}

variable "user_policies" {
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