variable "crawler_name" {
  type        = string
  description = "The name of the crawler"
}

variable "database_name" {
  type        = string
  description = "Glue database where results are written"
}

variable "crawler_iam_role" {
  type        = string
  description = "The IAM role friendly name (including path without leading slash), or ARN of an IAM role, used by the crawler to access other resources"
}

variable "table_prefix" {
  type        = string
  description = "The table prefix used for catalog tables that are created"
}

variable "bucket_target_path" {
  type        = string
  default     = ""
  description = "The path to the Amazon S3 target"
}

variable "jdbc_target_path" {
  type        = string
  default     = ""
  description = "The path of the JDBC target"
}

variable "jdbc_connection_name" {
  type        = string
  default     = ""
  description = "The name of the connection to use to connect to the JDBC target"
}
