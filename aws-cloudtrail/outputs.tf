output "cloudtrail_arn" {
  value       = aws_cloudtrail.main.arn
  description = "aws clodtrail ARN"
}

output "cloudtrail_id" {
  value       = aws_cloudtrail.main.id
  description = "aws cloudtrail ID"
}

output "cloudtrail_home_region" {
  value       = aws_cloudtrail.main.home_region
  description = "aws cloudtrail deployment region"
}

output "cloudtrail_tags_all" {
  value       = aws_cloudtrail.main.tags_all
  description = "aws cloudtrail deployment tags"
}