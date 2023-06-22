output "kms_key_id" {
  description = "The globally unique identifier for the key"
  value       = aws_kms_key.this.id
}

output "kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = aws_kms_key.this.arn
}
