output "elb_arn" {
  description = "The ARN of the network load balancer"
  value       = aws_lb.this.arn
}

output "elb_dns" {
  description = "The DNS of the network load balancer"
  value       = aws_lb.this.dns_name
}

output "elb_zone_id" {
  description = "The DNS zone ID of the network load balancer"
  value       = aws_lb.this.zone_id
}

output "elb_https_listener_arn" {
  value       = aws_lb_listener.https.arn
  description = "The ARN of the HTTPS listener (443)"
}
