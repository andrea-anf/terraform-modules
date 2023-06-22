data "aws_lambda_function" "existing" {
  function_name = var.config_handler_function_name
}

resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name          = var.alarm_name
  alarm_description   = var.alarm_description
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  threshold           = var.threshold
  period              = var.period
  unit                = var.unit

  namespace           = var.namespace
  metric_name         = var.metric_name
  statistic           = var.statistic
  treat_missing_data  = var.treat_missing_data
  datapoints_to_alarm = var.datapoints_to_alarm

  dimensions = {
    FunctionName = var.function_name
  }

  alarm_actions = [aws_sns_topic.this.arn]
}


resource "aws_sns_topic" "this" {
  name = "sns-topic-${var.alarm_name}"
}

resource "aws_sns_topic_subscription" "this" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = "lambda"
  endpoint  = data.aws_lambda_function.existing.arn

  filter_policy = jsonencode({
    "AlarmName" : [
      var.alarm_name
    ]
  })
}


resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = var.config_handler_function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.this.arn
}