output "arn" {
  value       = aws_rds_cluster.aurora.arn
  description = "Amazon Resource Name (ARN) of cluster"
}

output "id" {
  value       = aws_rds_cluster.aurora.id
  description = "RDS Cluster Identifier"
}
