variable "description" {
  type        = string
  description = "The description of the key as viewed in AWS console"
}

variable "deletion_window_in_days" {
  type        = number
  description = " The waiting period, specified in number of days, after which the key is deleated"
  default     = 7
}
