variable "default_tags" {
  type        = map(string)
  description = "Map with default tags"
}

variable "kms_master_key_id" {
  type        = string
  description = "The AWS KMS master key ID used for the SSE-KMS encryption"
}

variable "bucket_lifecycle_status" {
  type        = string
  default     = "Enabled"
  description = "Whether the rule is currently being applied. Valid values: Enabled or Disabled."
}

variable "bucket_expiration_days" {
  type        = number
  default     = 7
  description = "Lifetime, in days, of the objects that are subject to the rule."
}
