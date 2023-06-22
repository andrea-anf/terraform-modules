variable "roles_name" {
  type        = list(string)
  description = "Roles name list attached to the policy"
}

variable "policy_statements" {
  type = list(object(
    {
      effect    = string,
      actions   = list(string),
      resources = list(string)
    }
  ))
  description = "Policy statements"
}

variable "policy_name" {
  type        = string
  description = "Policy name"
}