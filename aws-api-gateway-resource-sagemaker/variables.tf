variable "api_gateway_name" {
  type        = string
  description = "API GTW name"
}

variable "api_performance" {
  type        = string
  description = "API performance"
}

variable "api_name" {
  type        = string
  description = "Name of the REST API. If importing an OpenAPI specification via the body argument, this corresponds to the info.title field"
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

variable sagemaker_endpoint_arn {
  type        = string
  description = "The Sagemaker endpoint ARN"
}

variable api_credentials_role_arn {
  type        = string
  description = "Credentials required for the integration. An IAM Role for Amazon API Gateway to assume"
}
