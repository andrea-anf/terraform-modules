variable "connection_name" {
  type        = string
  description = "The name of the connection"
}

variable "connection_type" {
  type        = string
  default     = "JDBC"
  description = "The type of the connection. Supported are: CUSTOM, JDBC, KAFKA, MARKETPLACE, MONGODB, and NETWORK"
}

variable "subnet_id" {
  type        = string
  description = "The subnet ID for physical connection requirements"
}

variable "security_group_id" {
  type        = string
  description = "The security group ID for physical connection requirements"
}

variable "jdbc_connection_url" {
  type        = string
  description = "The JDBC connection url for connection properties. e.g. jdbc:postgresql://rds_cluster_endpoint/database_name"
}

variable "rds_master_username" {
  type        = string
  description = "The RDS master username"
}

variable "rds_master_password" {
  type        = string
  description = "The RDS master password"
}

variable "jdbc_enforce_ssl" {
  type        = bool
  default     = true
  description = "Define if enforce SSL for connection"
}

variable "skip_custom_jdbc_cert" {
  type        = bool
  default     = false
  description = "Define if skip custom JDBC certification"
}

variable "custom_jdbc_cert_enabled" {
  type        = bool
  default     = false
  description = "Define if enable custom JDBC certification"
}

