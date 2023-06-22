// ------------------
//  S3 Bucket
// ------------------

variable "name" {
  type        = string
  description = "The name of the s3 bucket"
}

// ------------------
//  S3 Bucket public access block
// ------------------

variable "block_public_acls" {
  type        = bool
  default     = false
  description = "Whether Amazon S3 should block public ACLs for this bucket. "
}

variable "block_public_policy" {
  type        = bool
  default     = false
  description = " Whether Amazon S3 should block public bucket policies for this bucket"
}

variable "ignore_public_acls" {
  type        = bool
  default     = false
  description = "Whether Amazon S3 should ignore public ACLs for this bucket"
}

variable "restrict_public_buckets" {
  type        = bool
  default     = false
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket"
}

// ------------------
//  S3 Bucket Lifecycle configuration
// ------------------

variable "enable_lifecycle" {
  type        = bool
  default     = false
  description = "Define if enable a lifecycle configuration for the bucket. Default is set false"
}

variable "bucket_expiration_days" {
  type        = string
  description = "The lifetime, in days, of the objects that are subject to the rule"
  default     = 7
}

variable "bucket_lifecycle_status" {
  type        = string
  description = "Whether the rule is currently being applied. Valid values: Enabled or Disabled."
  default     = "Enabled"
}

// ------------------
//  S3 Bucket Server Side Encryption configuration
// ------------------

variable "enable_server_side_encryption" {
  type        = bool
  default     = false
  description = "Define if enable server side encryption for the bucket. Default is set false"
}

variable "kms_master_key_id" {
  type        = string
  default     = ""
  description = "AWS KMS master key ID used for the SSE-KMS encryption"
}

// ------------------
//  S3 Bucket logging
// ------------------

variable "enable_access_log" {
  type        = bool
  default     = false
  description = "Define if enable bucket access logging. Default is set false"
}

variable "log_bucket_id" {
  type        = string
  default     = ""
  description = "Name of the bucket where you want Amazon S3 to store server access logs"
}
