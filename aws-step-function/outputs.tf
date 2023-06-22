output "arn" {
  value       = aws_sfn_state_machine.this.arn
  description = "Amazon Resource Name (ARN) identifying your Step Function"
}

output "name" {
  value       = var.name
  description = "The step function name"
}