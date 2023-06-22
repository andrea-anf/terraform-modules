output "ecs_cluster_id" {
  value       = aws_ecs_cluster.this.id
  description = "The ID of the ECS cluster"
}

output "ecs_cluster_name" {
  value       = aws_ecs_cluster.this.name
  description = "The Name of the ECS cluster"
}