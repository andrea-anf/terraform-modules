output "arn" {
  value       = aws_ecs_task_definition.this.arn
  description = "Full ARN of the Task Definition (including both family and revision)"
}

output "arn_without_revision" {
  value       = aws_ecs_task_definition.this.arn_without_revision
  description = "ARN of the Task Definition with the trailing revision removed. This may be useful for situations where the latest task definition is always desired. If a revision isn't specified, the latest ACTIVE revision is used"
}