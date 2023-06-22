variable "name" {
  type        = string
  default     = ""
  description = "The name of the state machine"
}

variable "type" {
  type        = string
  default     = "EXPRESS"
  description = "The type of the state machine"
}

variable "logging_include_execution_data" {
  type        = bool
  default     = true
  description = "Determines whether execution data is included in your log. When set to false, data is excluded."
}

variable "logging_level" {
  type        = string
  default     = "ALL"
  description = "Defines which category of execution history events are logged. Valid values: ALL, ERROR, FATAL, OFF"
}

variable "logs_retention_in_days" {
  type        = number
  default     = 7
  description = "Specifies the number of days you want to retain log events in the specified log group. If you select 0, the events in the log group are always retained and never expire."
}

variable "iam_role_arn" {
  type        = string
  description = "The ARN of the IAM role with permissions for lambda"
}

variable "state_machine_definition" {
  type        = any
  description = "The state machine definition"
}
