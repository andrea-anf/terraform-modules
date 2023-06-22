variable "name" {
  type        = string
  description = "Name of the repository"
}

variable "kms_key_arn" {
  type        = string
  description = "The ARN of the KMS key"
}

variable "scan_on_push" {
  type        = bool
  default     = false
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false)"
}

variable "image_tag_mutability" {
  type        = string
  default     = "MUTABLE"
  description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE. Defaults to MUTABLE"
}

variable "force_delete" {
  type        = bool
  default     = false
  description = " If true, will delete the repository even if it contains images. Defaults to false"
}
