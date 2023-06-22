output "alb_arn" {
  description = "The ARN of the application load balancer"
  value       = aws_lb.this.arn
}

/* output alb_https_listener_arn {
  value       = aws_lb_listener.https.arn
  description = "The ARN of the HTTPS listener (443)"
} */

output "alb_http_listener_arn" {
  value       = aws_lb_listener.http.arn
  description = "The ARN of the HTTP listener (80)"
}

output "alb_container_listener_arn" {
  value       = aws_lb_listener.http.arn
  description = "The ARN of the HTTP listener (8000)"
}