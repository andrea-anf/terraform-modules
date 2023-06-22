resource "aws_sagemaker_model" "this" {
  name = var.name
  execution_role_arn = var.execution_role_arn
  
  vpc_config {
    security_group_ids = [var.security_group_id]
    subnets = var.subnet_ids
  }

  primary_container {
    image = var.primary_container_image 
    model_data_url = var.primary_container_model_data_url 
    environment = var.primary_container_environment
  }

  tags = {
    device = var.device
    name = var.model_name
  }
}

resource "aws_sagemaker_endpoint_configuration" "this" {
  name = var.endpoint_config_name

  production_variants {
    variant_name = "${var.device}-variant-1"
    model_name = aws_sagemaker_model.this.name
    initial_instance_count  = var.initial_instance_count
    instance_type = var.instance_type
    initial_variant_weight  = var.initial_variant_weight
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    device = var.device
    name = var.model_name
  }
}

resource "aws_sagemaker_endpoint" "this" {
  name = var.endpoint_name
  endpoint_config_name = aws_sagemaker_endpoint_configuration.this.name
  tags = {
    device = var.device
    name = var.model_name
  }
}
