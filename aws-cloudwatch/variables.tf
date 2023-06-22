variable "function_name" {
  type        = string
  description = "The name of the Lambda function to be monitored"
}

variable "config_handler_function_name" {
  type        = string
  description = "The name of the Lambda function config handler"
}

variable "alarm_name" {
  type        = string
  description = "The name of the alarm"
}

variable "alarm_description" {
  type        = string
  default     = ""
  description = "The description of the alarm"
}

variable "comparison_operator" {
  type        = string
  default     = "GreaterThanOrEqualToThreshold"
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold"
}


variable "evaluation_periods" {
  type        = number
  default     = 2
  description = "The number of periods over which data is compared to the specified threshold"
}

variable "threshold" {
  type        = number
  default     = 10
  description = "The value against which the specified statistic is compared"
}

variable "period" {
  type        = number
  default     = 60
  description = "The period in seconds over which the specified statistic is applied. Valid values are 10, 30, or any multiple of 60"
}

variable "unit" {
  type        = string
  description = "The unit for the alarm's associated metric"
}

variable "namespace" {
  type        = string
  default     = "AWS/Lambda"
  description = "The namespace for the alarm's associated metric"
}

variable "metric_name" {
  type        = string
  description = "The name for the alarm's associated metric"
}

variable "statistic" {
  type        = string
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
}

variable "treat_missing_data" {
  type        = string
  default     = "missing"
  description = "Sets how this alarm is to handle missing data points. The following values are supported: missing, ignore, breaching and notBreaching. Defaults to missing"
}

variable "datapoints_to_alarm" {
  type        = number
  default     = 1
  description = "The number of datapoints that must be breaching to trigger the alarm"
}