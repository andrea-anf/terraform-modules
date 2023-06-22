output connection_name {
  value       = aws_glue_connection.this.name
  description = "The name of the Glue connection"
}
