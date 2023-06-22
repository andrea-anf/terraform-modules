resource "aws_sns_topic" "this" {
  name = var.name
}

resource "aws_sns_topic_subscription" "this" {
  count     = length(var.subscription_email_list)
  topic_arn = aws_sns_topic.this.arn
  protocol  = "email"
  endpoint  = element(var.subscription_email_list, count.index)
}