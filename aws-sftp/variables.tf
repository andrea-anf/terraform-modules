variable "default_tags" {
  type        = map(string)
  description = "Map with default tags"
}

variable "vpc_id" {
  description = "AWS VPC id"
  type        = string
}

variable "subnet_ids" {
  description = "AWS Subnets ids"
  type        = list(string)
}

variable "kms_master_key_id" {
  type        = string
  description = "The AWS KMS master key ID used for the SSE-KMS encryption"
}

variable "transfer_user_name" {
  description = "The name used for log in to your SFTP server"
  type        = string
}

variable "role_arn" {
  description = "AWS Role Arn"
  type        = string
}


variable "network_security_group_ids" {
  description = "AWS Network security group ids to use"
  type        = list(string)
}

