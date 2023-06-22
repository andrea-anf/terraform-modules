// ------------------
//  Lambda Function
// ------------------

variable "function_name" {
  type        = string
  description = "The Lambda Function full name"
}

variable "timeout" {
  type        = number
  default     = 3
  description = "Amount of time your Lambda Function has to run in seconds. Defaults to 3"
}

variable "memory_size" {
  type        = number
  default     = 128
  description = "Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128"
}

variable "performance" {
  type        = string
  default     = "low"
  description = "A label to describe the lambda function performance (low, medium, high)"
}

variable "runtime" {
  type        = string
  description = "Identifier of the function's runtime"
}

variable "handler" {
  type        = string
  description = "Function entrypoint in your code"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs associated with the Lambda function"
}

variable "security_group_ids" {
  type        = list(string)
  description = " List of security group IDs associated with the Lambda"
}

variable "iam_role_arn" {
  type        = string
  description = "The ARN of the IAM role to assign to Lambda"
}

variable "env_variables" {
  type        = map(string)
  default     = {}
  description = " Map of environment variables that are accessible from the function code during execution"
}

variable package_type {
  type        = string
  default     = "Image"
  description = "Lambda deployment package type. Valid values are Zip and Image"
}

variable ecr_repository_url {
  type        = string
  description = "ECR image URI containing the function's deployment package."
}

// ------------------
//  Provisioned concurrency
// ------------------

variable "enable_provisioned_concurrency" {
  type        = bool
  default     = false
  description = "Enable Lambda provisioned concurrency"
}

variable "provisioned_concurrent_executions" {
  type        = number
  default     = 1
  description = "Amount of capacity to allocate. Must be greater than or equal to 1"
}

// ------------------
//  Cloudwatch log group
// ------------------

variable "logs_retention_in_days" {
  type        = number
  default     = 7
  description = "Specifies the number of days you want to retain log events in the specified log group. If you select 0, the events in the log group are always retained and never expire."
}

variable "config_handler_function_name" {
  type        = string
  default     = ""
  description = "The name of the Lambda function config handler"
}

variable "subscription_filter_name" {
  type        = string
  default     = "missing_redis_config"
  description = "The name of subscription filter"
}

variable "subscription_filter_pattern" {
  type        = string
  default     = "{ $.missing_config_file IS true }"
  description = "Subscription filter pattern"
}

variable "enable_log_subscription_filter" {
  type        = bool
  default     = false
  description = "Enable subscription filter"
}
