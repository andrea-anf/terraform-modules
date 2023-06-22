output "aws_budget_arn" {
  value       = aws_budgets_budget.terraform.arn
  description = "aws budget ARN"
}

output "aws_budget_id" {
  value       = aws_budgets_budget.terraform.id
  description = "aws budget ID"
}
