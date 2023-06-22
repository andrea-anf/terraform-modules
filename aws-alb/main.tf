data "aws_subnet" "selected" {
  id = var.subnet_ids[0]
}

data "aws_acm_certificate" "selected" {
  count = var.certificate_domain != "" ? 1 : 0

  domain      = var.certificate_domain
  statuses    = ["ISSUED"]
  most_recent = true
}

resource "aws_lb" "this" {
  name = var.name

  internal                   = var.internal
  load_balancer_type         = "application"
  security_groups            = var.security_group_ids
  subnets                    = toset(var.subnet_ids)
  enable_deletion_protection = var.enable_deletion_protection

  tags = { "Name" : var.name }
}

resource "aws_lb_listener" "https" {
  count = data.aws_acm_certificate.selected[0].arn ? 1 : 0

  load_balancer_arn = aws_lb.this.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-2019-08"
  certificate_arn   = data.aws_acm_certificate.selected[0].arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "ALB default response."
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "ALB default response."
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener" "container_port" {
  load_balancer_arn = aws_lb.this.arn
  port              = "8000"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "ALB default response."
      status_code  = "200"
    }
  }
}

resource "aws_lb_target_group" "this" {
  name = var.target_group_name

  target_type = "instance"
  port        = "8000"
  protocol    = "HTTP"
  vpc_id      = data.aws_subnet.selected.vpc_id

  deregistration_delay = 10

  health_check {
    interval            = 10
    path                = "/ping"
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener_rule" "container_port" {
  listener_arn = aws_lb_listener.container_port.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}