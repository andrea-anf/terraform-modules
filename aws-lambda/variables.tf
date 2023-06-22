# aws_s3_object
# See docs https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object

variable "bucket_id" {
  type        = string
  description = "The name of the S3 bucket where to push and get zip files"
}

variable "lambda_source_zip_file" {
  type        = string
  description = "The file .zip containing the source of the lambda function"
}

variable "lambda_layer_zip_files" {
  type        = list(any)
  default     = []
  description = "The files .zip containing the layers required by the lambda function"
}




# aws_lambda_layer_version
# See docs https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_layer_version

variable "compatible_runtimes" {
  type        = list(string)
  default     = ["python3.8"]
  description = " List of Runtimes this layer is compatible with. Up to 5 runtimes can be specified"
}


# aws_lambda_function
# See docs https://docs.aws.amazon.com/lambda/latest/dg/gettingstarted-limits.html"

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

# aws_cloudwatch_log_group
# See docs https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group

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
