output arn {
  value       = aws_sagemaker_endpoint.this.arn
  description = "The Amazon Resource Name (ARN) assigned by AWS to this endpoint"
}
