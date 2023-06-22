data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_sfn_state_machine" "existing" {
  name = var.step_function_name
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
  #count                = var.sf_integration == true ? 1 : 0
  rest_api_id             = data.aws_api_gateway_rest_api.shs.id
  resource_id             = aws_api_gateway_resource.api.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = var.api_http_method
  type                    = "AWS"
  passthrough_behavior    = "NEVER"
  uri                     = "arn:aws:apigateway:${var.region}:states:action/StartSyncExecution"
  credentials             = var.iam_role_arn
  timeout_milliseconds    = var.api_timeout

  # Transforms the incoming XML request to JSON
  request_templates = {
    "application/json" = <<EOF
      {
        "input" : "$util.escapeJavaScript("$input.body")",
        "stateMachineArn" : "${data.aws_sfn_state_machine.existing.arn}"
      }
    EOF
  }
  request_parameters = {
    "integration.request.header.Content-Type" = "'application/json'"
  }
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = data.aws_api_gateway_rest_api.shs.id
  stage_name  = var.api_stage_name
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.api.id,
      aws_api_gateway_method.method.id,
      aws_api_gateway_integration.integration.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
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

resource "aws_api_gateway_method_response" "this" {
  rest_api_id = data.aws_api_gateway_rest_api.shs.id
  resource_id = aws_api_gateway_resource.api.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = aws_api_gateway_integration_response.response.status_code
}