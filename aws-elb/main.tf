data "aws_subnet" "selected" {
  id = var.subnet_ids[0]
}

data "aws_acm_certificate" "selected" {
  domain      = var.certificate_domain == "" ? lower("*.${var.stage}.${var.scope}.aws.generali-cloud.com") : var.certificate_domain
  statuses    = ["ISSUED"]
  most_recent = true
}

resource "aws_lb" "this" {
  name = var.name
  tags = { "Name" : var.name }

  internal                   = var.internal
  load_balancer_type         = "network"
  subnets                    = toset(var.subnet_ids)
  enable_deletion_protection = var.enable_deletion_protection
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port              = "443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group" "this" {
  name = var.target_group_name

  target_type = "ip"
  port        = "443"
  protocol    = "TCP"
  vpc_id      = data.aws_subnet.selected.vpc_id

  ip_address_type = "ipv4"

  health_check {
    interval            = 10
    protocol            = "TCP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group_attachment" "this" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.target_ids
  port             = 443
}
