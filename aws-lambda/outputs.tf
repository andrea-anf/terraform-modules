output "arn" {
  value       = aws_lambda_function.this.arn
  description = "Amazon Resource Name (ARN) identifying your Lambda Function"
}

output "invoke_arn" {
  value       = aws_lambda_function.this.invoke_arn
  description = "ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri"
}

output "function_name" {
  value       = aws_lambda_function.this.function_name
  description = "The lambda function name"
}

output "version" {
  value       = aws_lambda_function.this.version
  description = "The lambda function version"
}