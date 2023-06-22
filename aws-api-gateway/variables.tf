
variable "scope" {
  type        = string
  description = "Scope"
}

variable "api_name" {
  type        = string
  description = "Name of the REST API. If importing an OpenAPI specification via the body argument, this corresponds to the info.title field"
}

variable "api_description" {
  type        = string
  description = "Description of the REST API."
}

variable "api_version" {
  type        = string
  default     = "1.0"
  description = "OpenAPI version"
}

variable "api_path" {
  type        = string
  default     = "/"
  description = "OpenAPI path"
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

variable "api_put_rest_api_mode" {
  type        = string
  default     = "merge"
  description = "Mode of the PutRestApi operation when importing an OpenAPI specification via the body argument (create or update operation). Valid values are merge and overwrite. If unspecificed, defaults to overwrite"
}

variable "vpc_endpoint_ids" {
  type        = list(string)
  description = "The VPC Endpoint ID"
}

variable "endpoint_types" {
  type        = list(string)
  default     = ["PRIVATE"]
  description = "The VPC Endpoint ID"
}

variable "logs_expiration_days" {
  type        = string
  default     = "7"
  description = "Days of log retention"
}

variable "route_hosted_zone" {
  type        = string
  description = "Name of the Route 53 hosted zone"
}

variable "route_hosted_zone_private" {
  type        = bool
  description = "Is Route 53 hosted zone private?"
}

variable "custom_domain" {
  type        = string
  description = "Name of the Api Gateway custom domain"
}

variable "certificate_domain" {
  type        = string
  description = "Name of the certificate domain"
}

variable "route_hosted_zone_record" {
  type        = string
  description = "Name of the record of the Route 53 hosted zone"
}

variable "api_gateway_private_endpoint" {
  type        = string
  description = "Private Endpoint URL"
}

variable "elb_dns" {
  type        = string
  default     = ""
  description = "ELB dns name"
}

variable "elb_zone_id" {
  type        = string
  default     = ""
  description = "ELB zone id"
}