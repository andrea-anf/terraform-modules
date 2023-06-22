variable "lambda_function_name" {
  type        = string
  description = "Name of the lambda function"
  default     = ""
}

variable "step_function_name" {
  type        = string
  description = "Name of the step function"
  default     = ""
}

#variable "sf_integration" {
#  type = bool
#  description = "Integrate API GW with step function"
#  default = false
#}
#
#variable "lambda_integration" {
#  type = bool
#  description = "Integrate API GW with lambda"
#  default = false
#}

variable "api_gateway_name" {
  type        = string
  description = "API GTW name"
}

variable "iam_role_arn" {
  type        = string
  description = "IAM Role arn"
}

variable "region" {
  type        = string
  description = "region"
  default     = "eu-central-1"
}

variable "api_performance" {
  type        = string
  description = "API performance"
}

variable "api_name" {
  type        = string
  description = "Name of the REST API. If importing an OpenAPI specification via the body argument, this corresponds to the info.title field"
}

variable "api_stage_name" {
  type        = string
  description = "API Stage name"
}

variable "api_http_method" {
  type        = string
  default     = "POST"
  description = "HTTP Method (GET, POST, PUT, DELETE, HEAD, OPTIONS, ANY). Default to POST"
}

variable "api_type" {
  type        = string
  default     = "AWS_PROXY"
  description = "Integration input's type. Valid values are HTTP, HTTP_PROXY, MOCK, AWS (for AWS services), AWS_PROXY (for Lambda proxy integration)"
}

variable "api_timeout" {
  type        = number
  default     = 29000
  description = "API Timeout"
}

