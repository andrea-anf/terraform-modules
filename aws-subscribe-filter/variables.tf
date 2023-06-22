variable name {
  type        = string
  description = "A name for the subscription filter"
}

variable role_arn {
  type        = string
  description = "The ARN of an IAM role that grants Amazon CloudWatch Logs permissions to deliver ingested log events to the destination"
}

variable log_group_name {
  type        = string
  description = "The name of the log group to associate the subscription filter with"
}

variable filter_pattern {
  type        = string
  description = "A valid CloudWatch Logs filter pattern for subscribing to a filtered stream of log events"
}

variable destination_arn {
  type        = string
  description = "description"
}
