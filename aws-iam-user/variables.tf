/* variable "name" {
  type        = string
  default     = "iam-user"
  description = "The name for the IAM user"
}

/* variable "kms_arn" {
  type        = string
  default     = ""
  description = "KMS ARN for S3"
}

variable "s3_arn" {
  type        = string
  default     = ""
  description = "S3 ARN"
}

variable "statements" {
  type = list(object({
    actions   = list(string)
    effect    = string
    resources = list(string)
  }))
  description = "The list of statements objects"
}
 */

variable "project_list" {
  type        = list(object({
    name = string,
    lambda_names = list(string),
    step_function_names = list(string),
    api_names = list(string)
  }))
  description = "List of objects containing name, bucket arn, kms arn, list of lambda and step function arns for each project"
}

variable name_prefix {
  type        = string
  default     = "iam-user"
  description = "The prefix for the IAM user name"
}

variable kms_arn {
  type        = string
  default     = ""
  description = "KMS ARN for S3"
}

variable s3_arn {
  type        = string
  default     = ""
  description = "S3 ARN"
}

variable api_gateway_id {
  type        = string
  default     = ""
  description = "API Gateway ID"
}