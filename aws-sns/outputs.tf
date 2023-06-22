output "arn" {
  value       = aws_sns_topic.this.arn
  description = "The arn of the SNS Topic"
}
