data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

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

resource "aws_api_gateway_method_response" "this" {
  rest_api_id = data.aws_api_gateway_rest_api.shs.id
  resource_id = aws_api_gateway_resource.api.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = aws_api_gateway_integration_response.response.status_code
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = data.aws_api_gateway_rest_api.shs.id
  resource_id             = aws_api_gateway_resource.api.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = var.api_http_method
  credentials             = var.api_credentials_role_arn
  type                    = var.api_type
  uri                     = "arn:aws:apigateway:${data.aws_region.current.name}:runtime.sagemaker:path/${var.sagemaker_endpoint_arn}"
  timeout_milliseconds    = var.api_timeout
}

resource "aws_api_gateway_deployment" "this" {
  depends_on  = [aws_api_gateway_integration.integration]
  rest_api_id = data.aws_api_gateway_rest_api.shs.id
  stage_name  = terraform.workspace
}

resource "aws_api_gateway_integration_response" "response" {
  rest_api_id = data.aws_api_gateway_rest_api.shs.id
  resource_id = aws_api_gateway_resource.api.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = "200"
  depends_on = [
    aws_api_gateway_integration.integration
  ]
}