output "vpc_id" {
  value       = aws_vpc.this.id
  description = "The VPC ID"
}

output "vpc_cidr_block" {
  value       = aws_vpc.this.cidr_block
  description = "The VPC cidr block"
}

output "subnet_cidr_blocks" {
  value       = aws_subnet.this[*].cidr_block
  description = "The subnet cidr blocks"
}