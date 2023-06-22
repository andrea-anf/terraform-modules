output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "vpc_cidr_block" {
  description = "The CIDR block used by VPC"
  value       = aws_vpc.this.cidr_block
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "nat_gateway_ids" {
  description = "Nat gateway IDs"
  value       = aws_nat_gateway.this[*].id
}

output "internet_gateway_id" {
  description = "The internet gateway ID"
  value       = aws_internet_gateway.this.id
}

output "internet_gateway_arn" {
  description = "The internet gateway ARN"
  value       = aws_internet_gateway.this.arn
}

output "public_route_table_id" {
  description = "The public route table ID"
  value       = aws_route_table.public[*].id
}

output "private_route_table_id" {
  description = "The private route table ID"
  value       = aws_route_table.private[*].id
}