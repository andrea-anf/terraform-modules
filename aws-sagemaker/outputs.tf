output "sagemaker_domain_id" {
  description = "SageMaker domain ID"
  value       = aws_sagemaker_domain.this.id
}

output "sagemaker_domain_arn" {
  description = "SageMaker domain ARN"
  value       = aws_sagemaker_domain.this.arn
}

output "sagemaker_domain_url" {
  description = "SageMaker domain URL"
  value       = aws_sagemaker_domain.this.url
}

output "sagemaker_lifecycle_config_arn" {
  description = "SageMaker domain URL"
  value       = aws_sagemaker_studio_lifecycle_config.this.arn
}

output sagemaker_endpoint_arn {
  value       = aws_sagemaker_endpoint.this.arn
  description = "The Sagemaker endpoint ARN"
}
