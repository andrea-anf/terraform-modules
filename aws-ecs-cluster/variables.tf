variable "name" {
  type        = string
  description = "Name of the cluster (up to 255 letters, numbers, hyphens, and underscores)"
}

variable "kms_key_id" {
  type        = string
  default     = ""
  description = " The AWS Key Management Service key ID to encrypt the data between the local client and the container"
}

variable "logging" {
  type        = string
  default     = "OVERRIDE"
  description = "The log setting to use for redirecting logs for your execute command results. Valid values are NONE, DEFAULT, and OVERRIDE"
}

variable "cloud_watch_encryption_enabled" {
  type        = bool
  default     = true
  description = "The log setting to use for redirecting logs for your execute command results. Valid values are NONE, DEFAULT, and OVERRIDE"
}

variable "logs_expiration_days" {
  type        = string
  default     = "30"
  description = "Specifies the number of days you want to retain log events in the specified log group"
}
