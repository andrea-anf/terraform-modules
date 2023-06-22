output "repository_arn" {
  value       = aws_ecr_repository.this.arn
  description = "Full ARN of the repository"
}

output "repository_name" {
  value       = aws_ecr_repository.this.name
  description = "The name of the repository"
}

output "repository_url" {
  value       = aws_ecr_repository.this.repository_url
  description = "The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName)"
}

output "registry_id" {
  value       = aws_ecr_repository.this.registry_id
  description = "The registry ID where the repository was created"
}


