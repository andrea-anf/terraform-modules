output "api_id" {
  description = "API GTW ID"
  value       = aws_api_gateway_rest_api.this.id
}

output "stage_arn" {
  value       = aws_api_gateway_stage.env.arn
  description = "ARN of the api-gateway stage"
}
