output "arn" {
  value       = aws_apprunner_service.this.arn
  description = "ARN of the App Runner service"
}

output "service_url" {
  value       = aws_apprunner_service.this.service_url
  description = "Subdomain URL that App Runner generated for this service. You can use this URL to access your service web application"
}

output "service_id" {
  value       = aws_apprunner_service.this.service_id
  description = "An alphanumeric ID that App Runner generated for this service. Unique within the AWS Region"
}

output "status" {
  value       = aws_apprunner_service.this.status
  description = "Current state of the App Runner service"
}
