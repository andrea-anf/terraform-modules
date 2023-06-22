data "aws_availability_zones" "available" {}

data "aws_vpc" "selected" {
  count = length(var.vpc_spoke_ids)
  id    = element(var.vpc_spoke_ids, count.index)
}

data "aws_route_table" "selected" {
  vpc_id = aws_vpc.this.id
}


resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "test-hub"
  }
}

resource "aws_subnet" "this" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.default_tags["Project_prefix"]}-subnet-${data.aws_availability_zones.available.names[0]}-${var.default_tags["Environment"]}"
  }
}

resource "aws_security_group" "this" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic from spoke VPCs"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.2.0.0/16"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_route" "this" {
  count                     = length(data.aws_vpc.selected)
  route_table_id            = data.aws_route_table.selected.id
  destination_cidr_block    = data.aws_vpc.selected[count.index].cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.this[count.index].id
  depends_on                = [data.aws_route_table.selected]
}

resource "aws_route53_zone" "this" {
  name = "shared-services-zone"

  vpc {
    vpc_id = aws_vpc.this.id
  }

  dynamic "vpc" {
    for_each = data.aws_vpc.selected

    content {
      vpc_id = data.aws_vpc.selected[vpc.key].id
    }

  }
}

resource "aws_vpc_peering_connection" "this" {
  count       = length(var.vpc_spoke_ids)
  peer_vpc_id = aws_vpc.this.id
  vpc_id      = element(var.vpc_spoke_ids, count.index)
  auto_accept = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}