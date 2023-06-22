variable "name" {
  type        = string
  description = "The name of the topic"
}

variable "subscription_email_list" {
  type        = list(string)
  description = "The list with email addresses to subscribe to the topic"
}