data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_lambda_function" "this" {
  function_name = var.function_name

  image_uri    = var.ecr_repository_url

  runtime = var.runtime
  handler = var.handler
  publish = true

  role = var.iam_role_arn

  timeout     = var.timeout
  memory_size = var.memory_size

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  environment {
    variables = var.env_variables
  }
}

resource "aws_lambda_provisioned_concurrency_config" "this" {
  count                             = var.enable_provisioned_concurrency ? 1 : 0
  function_name                     = aws_lambda_function.this.function_name
  provisioned_concurrent_executions = var.provisioned_concurrent_executions
  qualifier                         = aws_lambda_function.this.version

  lifecycle {
    ignore_changes = [
      provisioned_concurrent_executions
    ]
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.logs_retention_in_days
}

resource "aws_lambda_permission" "this" {
  count         = var.enable_log_subscription_filter == true ? 1 : 0
  action        = "lambda:InvokeFunction"
  function_name = var.config_handler_function_name
  principal     = "logs.${data.aws_region.current.name}.amazonaws.com"
  source_arn    = "${aws_cloudwatch_log_group.this.arn}:*"
}

resource "aws_cloudwatch_log_subscription_filter" "this" {
  count           = var.enable_log_subscription_filter == true ? 1 : 0
  name            = var.subscription_filter_name
  log_group_name  = aws_cloudwatch_log_group.this.name
  filter_pattern  = var.subscription_filter_pattern
  destination_arn = "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${var.config_handler_function_name}"
  distribution    = "Random"
}