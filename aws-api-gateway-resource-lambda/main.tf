data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_lambda_function" "existing" {
  function_name = var.lambda_function_name
}

data "aws_api_gateway_rest_api" "shs" {
  name = var.api_gateway_name
}

data "aws_api_gateway_resource" "performance" {
  rest_api_id = data.aws_api_gateway_rest_api.shs.id
  path        = "/${var.api_performance}"
}

resource "aws_api_gateway_resource" "api" {
  path_part   = var.api_name
  parent_id   = data.aws_api_gateway_resource.performance.id
  rest_api_id = data.aws_api_gateway_rest_api.shs.id
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = data.aws_api_gateway_rest_api.shs.id
  resource_id   = aws_api_gateway_resource.api.id
  http_method   = var.api_http_method
  authorization = "AWS_IAM"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = data.aws_api_gateway_rest_api.shs.id
  resource_id             = aws_api_gateway_resource.api.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = var.api_http_method
  type                    = var.api_type
  uri                     = data.aws_lambda_function.existing.invoke_arn
  timeout_milliseconds    = var.api_timeout
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "${var.api_gateway_name}-${var.lambda_function_name}"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${data.aws_api_gateway_rest_api.shs.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.api.path}"
}

resource "aws_api_gateway_deployment" "this" {
  depends_on  = [aws_api_gateway_integration.integration]
  rest_api_id = data.aws_api_gateway_rest_api.shs.id
  stage_name  = terraform.workspace
}

