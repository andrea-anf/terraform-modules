output "cloudwatch_lambda_duration_arn" {
  value       = aws_cloudwatch_metric_alarm.this.arn
  description = "AWS Clodwatch ARN for lambda duration metrics"
}

output "cloudwatch_lambda_duration_id" {
  value       = aws_cloudwatch_metric_alarm.this.id
  description = "AWS Cloudwatch ID for lambda duration metrics"
}

