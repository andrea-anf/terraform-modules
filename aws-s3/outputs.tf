output "s3_bucket_arn" {
  description = "The bucket ARN"
  value       = aws_s3_bucket.this.arn
}

output "s3_bucket_id" {
  description = "The bucket ID"
  value       = aws_s3_bucket.this.id
}
