data "aws_caller_identity" "current" {}

data "aws_ssm_parameter" "ecs_image_recommended" {
  name = "/MINION/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

data "aws_ami" "ecs_image" {
  owners      = concat([data.aws_caller_identity.current.account_id], var.image_owner_ids)
  most_recent = true

  filter {
    name   = "image-id"
    values = [data.aws_ssm_parameter.ecs_image_recommended.value]
  }
}

data "aws_subnet" "selected" {
  id = var.subnet_ids[0]
}

resource "aws_launch_template" "this" {
  name = var.launch_template_name
  tags = { "Name" : var.launch_template_name }

  image_id      = data.aws_ami.ecs_image.image_id
  instance_type = var.launch_template_instance_type

  iam_instance_profile {
    name = "Basic"
  }

  key_name = "${var.scope}-${var.stage}-default"

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups             = [var.launch_template_security_group_id]
    device_index                = 0
  }

  # Block device mapping would break on next tf versions
  # Suggested solution is the use of a dynamic block
  # https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = var.root_volume_size
    }
  }

  user_data = base64encode(<<EOF
#!/bin/bash
echo ECS_CLUSTER=${var.cluster_name} >> /etc/ecs/ecs.config
echo ECS_CONTAINER_INSTANCE_PROPAGATE_TAGS_FROM=ec2_instance >> /etc/ecs/ecs.config
EOF
  )
}

resource "aws_autoscaling_group" "this" {
  name = var.name

  desired_capacity    = 0
  max_size            = var.autoscaling_max_size
  min_size            = var.autoscaling_min_size
  default_cooldown    = 60
  force_delete        = true
  vpc_zone_identifier = toset(var.subnet_ids)

  termination_policies  = ["OldestInstance"]
  protect_from_scale_in = true

  health_check_type         = "EC2"
  health_check_grace_period = var.autoscaling_health_check_grace_period
  enabled_metrics           = ["GroupInServiceCapacity", "GroupTotalCapacity", "GroupDesiredCapacity"]

  launch_template {
    id      = aws_launch_template.this.id
    version = var.autoscaling_launch_template_version
  }

  tag {
    key                 = "Name"
    value               = "${var.name}-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "scope"
    value               = var.scope
    propagate_at_launch = true
  }

  tag {
    key                 = "stage"
    value               = var.stage
    propagate_at_launch = true
  }

  tag {
    key                 = "managed-by"
    value               = "autoscalinggroup ${var.name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = ""
    propagate_at_launch = true
  }

  wait_for_capacity_timeout = "0" // disable waiting in terraform until machines are healthy

  lifecycle {
    ignore_changes = [desired_capacity]
  }
}


resource "aws_ecs_capacity_provider" "this" {
  name = var.ecs_capacity_provider_name

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.this.arn
    managed_termination_protection = var.autoscaling_protect_from_scale_in ? "ENABLED" : "DISABLED"

    managed_scaling {
      maximum_scaling_step_size = var.managed_scaling_maximum_scaling_step_size
      minimum_scaling_step_size = var.managed_scaling_minimum_scaling_step_size
      status                    = "ENABLED"
      target_capacity           = var.managed_scaling_target_capacity
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "managed_scaling" {
  cluster_name = var.cluster_name

  capacity_providers = [aws_ecs_capacity_provider.this.name]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.this.name
    base              = 0
    weight            = 100
  }
}
