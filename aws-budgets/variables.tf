variable "default_tags" {
  type        = map(string)
  description = "Map with default tags"
}

variable "budget_type" {
  type        = string
  default     = "COST"
  description = "Whether this budget tracks monetary cost or usage"
}

variable "limit_amount" {
  type        = string
  default     = "100"
  description = "The amount of cost or usage being measured for a budget"
}

variable "limit_unit" {
  type        = string
  default     = "USD"
  description = "The unit of measurement used for the budget forecast, actual spend, or budget threshold, such as dollars or GB"
}

variable "time_period_start" {
  type        = string
  default     = "2017-07-01_00:00"
  description = "The start of the time period covered by the budget. Format: 2017-01-01_12:00"
}

variable "time_period_end" {
  type        = string
  default     = "2087-06-15_00:00"
  description = "The end of the time period covered by the budget. Format: 2017-01-01_12:00"
}

variable "time_unit" {
  type        = string
  default     = "MONTHLY"
  description = "The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY, and DAILY"
}

variable "notification_comparison_operator" {
  type        = string
  default     = "GREATER_THAN"
  description = "Comparison operator to use to evaluate the condition. Can be LESS_THAN, EQUAL_TO or GREATER_THAN"
}

variable "notification_threshold" {
  type        = number
  default     = 1
  description = "Threshold when the notification should be sent"
}

variable "notification_threshold_type" {
  type        = string
  default     = "PERCENTAGE"
  description = "What kind of threshold is defined. Can be PERCENTAGE OR ABSOLUTE_VALUE"
}

variable "notification_notification_type" {
  type        = string
  default     = "FORECASTED"
  description = "What kind of budget value to notify on. Can be ACTUAL or FORECASTED"
}

variable "notification_subscriber_email_addresses" {
  type        = list(string)
  description = "E-Mail addresses to notify."
}