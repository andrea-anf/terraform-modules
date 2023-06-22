data "aws_subnet" "this" {
  id = var.subnet_ids[0]
}

resource "aws_sagemaker_domain" "this" {
  domain_name = var.name

  auth_mode  = var.sagemaker_domain_auth_mode
  vpc_id     = data.aws_subnet.this.vpc_id
  subnet_ids = var.subnet_ids

  retention_policy {
    home_efs_file_system = var.retention_policy_home_efs
  }

  default_space_settings {
    execution_role = var.ext_checker_iam_role

    jupyter_server_app_settings {
      default_resource_spec {
        instance_type        = "system"
        lifecycle_config_arn = aws_sagemaker_studio_lifecycle_config.this.arn
      }

      lifecycle_config_arns = [aws_sagemaker_studio_lifecycle_config.this.arn]
    }
  }

  default_user_settings {
    execution_role = var.ext_checker_iam_role

    jupyter_server_app_settings {
      default_resource_spec {
        instance_type        = "system"
        lifecycle_config_arn = aws_sagemaker_studio_lifecycle_config.this.arn
      }

      lifecycle_config_arns = [aws_sagemaker_studio_lifecycle_config.this.arn]
    }
  }
}

resource "aws_sagemaker_studio_lifecycle_config" "this" {
  studio_lifecycle_config_name     = "install-autoshutdown-extension"
  studio_lifecycle_config_app_type = "JupyterServer"
  studio_lifecycle_config_content  = filebase64("${path.module}/on-jupyter-server-start.sh")
}
#   studio_lifecycle_config_content = filebase64(templatefile("${path.module}/on-jupyter-server-start.sh", {timeout=var.ext_autoshutdown_timeout}))

resource "aws_sagemaker_user_profile" "this" {
  count             = length(var.user_profile_name_list)
  domain_id         = aws_sagemaker_domain.this.id
  user_profile_name = element(var.user_profile_name_list, count.index)
}

resource "aws_sagemaker_space" "this" {
  domain_id  = aws_sagemaker_domain.this.id
  space_name = "${var.name}-space"
}

resource "aws_sagemaker_code_repository" "this" {
  for_each = var.repository_object_map
  code_repository_name = "${var.name}-${each.key}"

  git_config {
    repository_url = each.value.repository_url
    secret_arn     = each.value.secret_arn
  }
}

resource "aws_sagemaker_endpoint_configuration" "this" {
  name = "${var.endpoint_name}-config"

  production_variants {
    variant_name           = "${var.endpoint_name}-production-variant"
    model_name             = var.endpoint_model_name
    initial_instance_count = var.endpoint_initial_instance_count
    instance_type          = var.endpoint_instance_type
  }
}

resource "aws_sagemaker_endpoint" "this" {
  name                 = var.endpoint_name
  endpoint_config_name = aws_sagemaker_endpoint_configuration.this.name
}