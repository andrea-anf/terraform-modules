
resource "aws_vpc_endpoint" "lambda" {
  service_name      = "com.amazonaws.${var.default_tags["Region"]}.lambda"
  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.this.id

  security_group_ids = [
    aws_security_group.this.id,
  ]

  private_dns_enabled = false
}

resource "aws_vpc_endpoint_subnet_association" "lambda" {
  count           = length(aws_subnet.this)
  vpc_endpoint_id = aws_vpc_endpoint.lambda.id
  subnet_id       = aws_subnet.this.id
}

resource "aws_route53_record" "lambda" {
  zone_id = aws_route53_zone.this.zone_id
  name    = "lambda"
  type    = "A"

  alias {
    name                   = aws_vpc_endpoint.lambda.dns_entry[0].dns_name
    zone_id                = aws_vpc_endpoint.lambda.dns_entry[0].hosted_zone_id
    evaluate_target_health = false
  }
}


resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.this.id
  service_name = "com.amazonaws.${var.default_tags["Region"]}.s3"
}

resource "aws_vpc_endpoint_route_table_association" "s3" {
  route_table_id  = data.aws_route_table.selected.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

/* resource "aws_route53_record" "s3" {
  zone_id = aws_route53_zone.this.zone_id
  name    = "s3"
  type    = "A"

  alias {
    name                   = aws_vpc_endpoint.s3.dns_entry[0].dns_name
    zone_id                = aws_vpc_endpoint.s3.dns_entry[0].hosted_zone_id
    evaluate_target_health = false
  }
}
 */


resource "aws_vpc_endpoint" "step_function" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${var.default_tags["Region"]}.states"
  vpc_endpoint_type = "Interface"
}

resource "aws_vpc_endpoint_subnet_association" "step_function" {
  vpc_endpoint_id = aws_vpc_endpoint.step_function.id
  subnet_id       = aws_subnet.this.id
}

resource "aws_route53_record" "step_function" {
  zone_id = aws_route53_zone.this.zone_id
  name    = "step_function"
  type    = "A"

  alias {
    name                   = aws_vpc_endpoint.step_function.dns_entry[0].dns_name
    zone_id                = aws_vpc_endpoint.step_function.dns_entry[0].hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${var.default_tags["Region"]}.ecr.dkr"
  vpc_endpoint_type = "Interface"
}

resource "aws_vpc_endpoint_subnet_association" "ecr_dkr" {
  vpc_endpoint_id = aws_vpc_endpoint.ecr_dkr.id
  subnet_id       = aws_subnet.this.id
}

resource "aws_route53_record" "ecr_dkr" {
  zone_id = aws_route53_zone.this.zone_id
  name    = "ecr_dkr"
  type    = "A"

  alias {
    name                   = aws_vpc_endpoint.ecr_dkr.dns_entry[0].dns_name
    zone_id                = aws_vpc_endpoint.ecr_dkr.dns_entry[0].hosted_zone_id
    evaluate_target_health = false
  }
}


resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${var.default_tags["Region"]}.ecr.api"
  vpc_endpoint_type = "Interface"
}

resource "aws_vpc_endpoint_subnet_association" "ecr_api" {
  vpc_endpoint_id = aws_vpc_endpoint.ecr_api.id
  subnet_id       = aws_subnet.this.id
}

resource "aws_route53_record" "ecr_api" {
  zone_id = aws_route53_zone.this.zone_id
  name    = "ecr_api"
  type    = "A"

  alias {
    name                   = aws_vpc_endpoint.ecr_api.dns_entry[0].dns_name
    zone_id                = aws_vpc_endpoint.ecr_api.dns_entry[0].hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_vpc_endpoint" "logs" {
  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${var.default_tags["Region"]}.logs"
  vpc_endpoint_type = "Interface"
}

resource "aws_vpc_endpoint_subnet_association" "logs" {
  vpc_endpoint_id = aws_vpc_endpoint.logs.id
  subnet_id       = aws_subnet.this.id
}

resource "aws_route53_record" "logs" {
  zone_id = aws_route53_zone.this.zone_id
  name    = "logs"
  type    = "A"

  alias {
    name                   = aws_vpc_endpoint.logs.dns_entry[0].dns_name
    zone_id                = aws_vpc_endpoint.logs.dns_entry[0].hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_vpc_endpoint_policy" "logs" {
  vpc_endpoint_id = aws_vpc_endpoint.logs.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "*"
      }
    ]
  })
}
