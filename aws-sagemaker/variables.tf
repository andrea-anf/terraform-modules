variable "name" {
  type        = string
  description = "The name of Sagemaker domain"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The list of subnet ids to provide to SageMaker"
}


variable "user_profile_name_list" {
  type        = list(string)
  description = "The list of user profiles to create"
}

variable "sagemaker_domain_auth_mode" {
  type        = string
  default     = "IAM"
  description = "The mode of authentication that members use to access the domain. Valid values are IAM and SSO."
}

variable "retention_policy_home_efs" {
  type        = string
  default     = "Delete"
  description = "The retention policy for data stored on an EFS volume. Valid values are Retain or Delete. Default value is Retain."
}

variable "sns_topic_arn" {
  type        = string
  description = "The ARN of the SNS Topic"
}

variable "ext_checker_iam_role" {
  type        = string
  description = "The IAM role to able the extension checker lambda to publish on SNS"
}

variable "ext_checker_bucket_id" {
  type        = string
  description = "The S3 bucket where the extension checker will store the lambda"
}

variable "ext_checker_event_schedule_expression" {
  type        = string
  description = "The scheduling expression for the extension checker 'auto-shutdown'. For example, cron(0 20 * * ? *) or rate(5 minutes)"
}

variable "ext_autoshutdown_timeout" {
  type        = string
  default     = "120"
  description = "Define how much time the Kernel can be in an idle state before being deleted"
}

variable "repository_object_map" {
  type        = map(any)
  description = "The map containing objects with inside repository url and secret arn"
}
