
resource "aws_budgets_budget" "terraform" {
  name              = "${var.default_tags["Project_prefix"]}-monthly-budget"
  budget_type       = var.budget_type
  limit_amount      = var.limit_amount
  limit_unit        = var.limit_unit
  time_period_start = var.time_period_start
  time_period_end   = var.time_period_end
  time_unit         = var.time_unit

  cost_filter {
    name = "TagKeyValue"
    values = [
      "user:ManagedBy$terraform",
    ]
  }

  notification {
    comparison_operator        = var.notification_comparison_operator
    threshold                  = var.notification_threshold
    threshold_type             = var.notification_threshold_type
    notification_type          = var.notification_notification_type
    subscriber_email_addresses = var.notification_subscriber_email_addresses
  }
}