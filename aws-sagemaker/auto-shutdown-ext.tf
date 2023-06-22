data "aws_region" "current" {}

resource "aws_s3_object" "this" {
  key           = "ext-checker.zip"
  bucket        = var.ext_checker_bucket_id
  source        = "${path.module}/extension-checker/ext_checker.zip"
  force_destroy = true
}


resource "aws_lambda_function" "this" {
  function_name = "${var.name}-auto-shutdown-ext"
  s3_bucket     = var.ext_checker_bucket_id
  s3_key        = aws_s3_object.this.key
  role          = var.ext_checker_iam_role
  handler       = "ext_checker.lambda_handler"
  runtime       = "python3.7"
  timeout       = 900
}

resource "aws_cloudwatch_event_rule" "this" {
  name                = "${var.name}-sagemaker-ext-checker-event"
  description         = "Trigger ${aws_lambda_function.this.function_name} to check the Sagemaker extension 'auto-shutdown'"
  schedule_expression = var.ext_checker_event_schedule_expression
}

resource "aws_cloudwatch_event_target" "this" {
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = "TriggerLambda"
  arn       = aws_lambda_function.this.arn

  input = jsonencode({
    "region" : "${data.aws_region.current.name}",
    "sns-topic" : "${var.sns_topic_arn}"
  })
}

resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this.arn
}
