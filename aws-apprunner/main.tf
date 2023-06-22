resource "aws_apprunner_service" "this" {
  service_name = var.name

  source_configuration {
    image_repository {
      image_configuration {
        port = var.image_port
      }
      image_identifier      = var.image_identifier #"public.ecr.aws/aws-containers/hello-app-runner:latest"
      image_repository_type = var.image_repository_type
    }
    auto_deployments_enabled = var.auto_deployments_enabled
  }

  tags = {
    Name = var.name
  }
}

resource "aws_apprunner_auto_scaling_configuration_version" "this" {
  auto_scaling_configuration_name = "${var.name}-auto-scaling"

  max_concurrency = var.max_concurrency
  max_size        = var.max_size
  min_size        = var.min_size

  tags = {
    Name = "${var.name}-auto-scaling"
  }
}