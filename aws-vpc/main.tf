data "aws_availability_zones" "available" {}

resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true

  tags = {
    "Name" = "${var.default_tags["Project_prefix"]}-vpc-${var.default_tags["Environment"]}"
  }
}

resource "aws_security_group" "this" {
  name   = "${var.default_tags["Project_prefix"]}-vpc-sg-${var.default_tags["Environment"]}"
  vpc_id = aws_vpc.this.id

  dynamic "ingress" {
    for_each = var.vpc_sg_ingress_rule_list
    content {
      description      = ingress.value["description"]
      from_port        = ingress.value["from_port"]
      to_port          = ingress.value["to_port"]
      protocol         = ingress.value["protocol"]
      cidr_blocks      = tolist(ingress.value["cidr_blocks"])
      ipv6_cidr_blocks = tolist(ingress.value["ipv6_cidr_blocks"])
    }
  }

  dynamic "egress" {
    for_each = var.vpc_sg_egress_rule_list
    content {
      description      = egress.value["description"]
      from_port        = egress.value["from_port"]
      to_port          = egress.value["to_port"]
      protocol         = egress.value["protocol"]
      cidr_blocks      = tolist(egress.value["cidr_blocks"])
      ipv6_cidr_blocks = tolist(egress.value["ipv6_cidr_blocks"])
    }
  }
}