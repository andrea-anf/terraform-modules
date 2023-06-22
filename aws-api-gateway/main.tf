data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions   = ["execute-api:Invoke"]
    resources = ["*"]
  }
}

# The "REST API" is the container for all of the other API Gateway objects
resource "aws_api_gateway_rest_api" "this" {
  name = var.api_name
  description = var.api_description

  policy = data.aws_iam_policy_document.this.json
  put_rest_api_mode = var.api_put_rest_api_mode

  endpoint_configuration {
    types            = var.endpoint_types
    vpc_endpoint_ids = var.route_hosted_zone_private == true ? var.vpc_endpoint_ids : null
  }
}

resource "aws_api_gateway_resource" "low" {
  path_part   = "low"
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.this.id
}

resource "aws_api_gateway_resource" "medium" {
  path_part   = "medium"
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.this.id
}

resource "aws_api_gateway_resource" "high" {
  path_part   = "high"
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.this.id
}

resource "aws_api_gateway_resource" "ml" {
  path_part   = "ml"
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.this.id
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = "stg"
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.low.id,
      aws_api_gateway_resource.medium.id,
      aws_api_gateway_resource.high.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudwatch_log_group" "api_gateway_log" {
  name = "${var.api_name}-logs"
  retention_in_days = var.logs_expiration_days
}

resource "aws_api_gateway_stage" "env" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = terraform.workspace
  xray_tracing_enabled = true
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway_log.arn
    format          = "{\"requestId\":\"$context.requestId\",\"ip\":\"$context.identity.sourceIp\",\"caller\":\"$context.identity.caller\",\"user\":\"$context.identity.user\",\"requestTime\":$context.requestTimeEpoch,\"httpMethod\":\"$context.httpMethod\",\"resourcePath\":\"$context.resourcePath\",\"status\":$context.status,\"protocol\":\"$context.protocol\",\"path\":\"$context.path\",\"stage\":\"$context.stage\",\"xrayTraceId\":\"$context.xrayTraceId\",\"userAgent\":\"$context.identity.userAgent\",\"responseLength\":$context.responseLength}"
  }
}

data "aws_route53_zone" "domain" {
  name         = var.route_hosted_zone
  private_zone = var.route_hosted_zone_private
}

data "aws_acm_certificate" "issued" {
  domain   = "*.${var.certificate_domain}"
  statuses = ["ISSUED"]
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = data.aws_acm_certificate.issued.arn
}

resource "aws_api_gateway_domain_name" "this" {
  domain_name              = "${var.custom_domain}.${var.certificate_domain}"
  regional_certificate_arn = aws_acm_certificate_validation.this.certificate_arn

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_route53_record" "api_gateway" {
  name    = aws_api_gateway_domain_name.this.domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.domain.id

  alias {
    evaluate_target_health = true
    name                   = var.route_hosted_zone_private == true ? var.elb_dns : aws_api_gateway_domain_name.this.regional_domain_name
    zone_id                = var.route_hosted_zone_private == true ? var.elb_zone_id : aws_api_gateway_domain_name.this.regional_zone_id
  }
}

resource "aws_api_gateway_base_path_mapping" "example" {
  api_id      = aws_api_gateway_rest_api.this.id
  domain_name = aws_api_gateway_domain_name.this.domain_name
}