data "aws_subnet" "selected" {
  count = length(var.private_subnet_ids)
  id    = element(var.private_subnet_ids, count.index)
}

data "aws_vpc" "selected" {
  id = data.aws_subnet.selected[0].vpc_id
}

resource "aws_elasticache_subnet_group" "this" {
  name       = var.subnet_group_name
  subnet_ids = var.private_subnet_ids
}

resource "aws_elasticache_replication_group" "default" {
  replication_group_id = var.replication_group_name
  description          = var.replication_group_description
  security_group_ids   = [var.security_group_id]
  node_type            = var.node_type
  port                 = 6379
  engine               = "redis"
  engine_version       = var.engine_version

  parameter_group_name       = var.parameter_group_name
  at_rest_encryption_enabled = var.at_rest_encryption_enabled

  preferred_cache_cluster_azs = data.aws_subnet.selected[*].availability_zone
  subnet_group_name           = aws_elasticache_subnet_group.this.name
  automatic_failover_enabled  = var.automatic_failover_enabled
  replicas_per_node_group     = var.replicas_per_node_group
  num_node_groups             = var.num_node_groups

  apply_immediately          = var.apply_immediately
  auto_minor_version_upgrade = var.auto_minor_version_upgrade

  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.slow_log.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "slow-log"
  }

  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.engine_log.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "engine-log"
  }
}

resource "aws_cloudwatch_log_group" "slow_log" {
  name              = "${var.log_group_name}-slow"
  retention_in_days = var.logs_expiration_days
}

resource "aws_cloudwatch_log_stream" "slow_log" {
  name           = "${var.log_stream_name}-slow"
  log_group_name = aws_cloudwatch_log_group.slow_log.name
}

resource "aws_cloudwatch_log_group" "engine_log" {
  name              = "${var.log_group_name}-engine"
  retention_in_days = var.logs_expiration_days
}

resource "aws_cloudwatch_log_stream" "engine_log" {
  name           = "${var.log_stream_name}-engine"
  log_group_name = aws_cloudwatch_log_group.engine_log.name
}