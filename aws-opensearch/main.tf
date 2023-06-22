data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_subnet" "selected" {
  id = var.subnet_ids[0]
}

data "aws_vpc" "selected" {
  id = data.aws_subnet.selected.vpc_id
}

resource "aws_security_group" "this" {
  name        = "${var.domain}-sg"
  vpc_id      = data.aws_subnet.selected.vpc_id
  description = "Allow inbound HTTP traffic"

  ingress {
    description = "HTTP from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"

    cidr_blocks = [
      data.aws_vpc.selected.cidr_block,
    ]
  }
}

resource "aws_cloudwatch_log_group" "index_slow_logs" {
  name              = "/aws/opensearch/${var.domain}/index-slow"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "search_slow_logs" {
  name              = "/aws/opensearch/${var.domain}/search-slow"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "es_application_logs" {
  name              = "/aws/opensearch/${var.domain}/es-application"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_resource_policy" "this" {
  policy_name = "${var.domain}-domain-log-resource-policy"

  policy_document = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "es.amazonaws.com"
      },
      "Action": [
        "logs:PutLogEvents",
        "logs:PutLogEventsBatch",
        "logs:CreateLogStream"
      ],
      "Resource": [
        "${aws_cloudwatch_log_group.index_slow_logs.arn}:*",
        "${aws_cloudwatch_log_group.search_slow_logs.arn}:*",
        "${aws_cloudwatch_log_group.es_application_logs.arn}:*"
      ],
      "Condition": {
          "StringEquals": {
              "aws:SourceAccount": "${data.aws_caller_identity.current.account_id}"
          },
          "ArnLike": {
              "aws:SourceArn": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain}"
          }
      }
    }
  ]
}
CONFIG
}

resource "aws_opensearch_domain" "opensearch" {
  domain_name    = var.domain
  engine_version = var.engine_version

  cluster_config {
    dedicated_master_count   = var.dedicated_master_count
    dedicated_master_type    = var.dedicated_master_type
    dedicated_master_enabled = var.dedicated_master_enabled
    instance_type            = var.instance_type
    instance_count           = var.instance_count
    zone_awareness_enabled   = var.zone_awareness_enabled
    zone_awareness_config {
      availability_zone_count = var.zone_awareness_enabled ? length(var.subnet_ids) : null
    }
  }

# !!! READ BEFORE CHANGE enable_at_rest VALUES
#
# You can enable encrypt_at_rest in place for an existing, unencrypted domain only 
# if you are using OpenSearch or your Elasticsearch version is 6.7 or greater. For other versions,
# if you enable encrypt_at_rest, Terraform with recreate the domain, potentially causing data loss. 
# For any version, if you disable encrypt_at_rest for an existing, encrypted domain, Terraform will 
# recreate the domain, potentially causing data loss. If you change the kms_key_id, 
# Terraform will also recreate the domain, potentially causing data loss.
  encrypt_at_rest {
    enabled = var.enable_encrypt_at_rest
  }

  domain_endpoint_options {
    enforce_https       = var.enforce_https
    tls_security_policy = var.tls_security_policy

    custom_endpoint_enabled         = var.custom_endpoint_enabled
    custom_endpoint                 = var.custom_endpoint_domain
    custom_endpoint_certificate_arn = ""
  }

  ebs_options {
    ebs_enabled = var.ebs_enabled
    volume_size = var.ebs_volume_size
    volume_type = var.volume_type
    throughput  = var.throughput
  }

  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.index_slow_logs.arn
    log_type                 = "INDEX_SLOW_LOGS"
  }

  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.search_slow_logs.arn
    log_type                 = "SEARCH_SLOW_LOGS"
  }

  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.es_application_logs.arn
    log_type                 = "ES_APPLICATION_LOGS"
  }

  node_to_node_encryption {
    enabled = var.enable_node_to_node_encryption
  }

  vpc_options {
    subnet_ids = var.subnet_ids

    security_group_ids = [aws_security_group.this.id]
  }


  access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain}/*"
        }
    ]
}
CONFIG
}
