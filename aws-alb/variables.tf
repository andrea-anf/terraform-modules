// ------------------
//  Data
// ------------------

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs where to attach the ALB"
}

variable "certificate_domain" {
  type        = string
  default     = ""
  description = "Domain of the certificate to look up. If no certificate is found with this name, an error will be returned"
}

// ------------------
//  Load Balancer
// ------------------

variable "name" {
  type        = string
  description = "The name of the LB. This name must be unique within your AWS account, can have a maximum of 32 characters, must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen. If not specified, Terraform will autogenerate a name beginning with tf-lb"
}

variable "internal" {
  type        = bool
  default     = true
  description = "If true, the LB will be internal"
}

variable "security_group_ids" {
  type        = list(string)
  default     = ""
  description = "The security group IDs to attach to the ALB, if empty the default one will be fetched"
}

variable "enable_deletion_protection" {
  type        = bool
  default     = false
  description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false"
}

// ------------------
//  Load Balancer - target group
// ------------------

variable "target_group_name" {
  type        = string
  description = "The name of the target group"
}








variable "alb_account" {
  type        = string
  default     = "054676820928"
  description = "The account number for the ALB (default is set for eu-central-1). See https://docs.aws.amazon.com/elasticloadbalancing/latest/application/enable-access-logging.html"
}

variable "enable_access_logs" {
  type        = bool
  default     = true
  description = "Define if send access logs to a S3 Bucket"
}

