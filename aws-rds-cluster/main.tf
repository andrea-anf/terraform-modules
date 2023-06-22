resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = var.cluster_identifier
  engine                  = var.engine
  engine_mode             = var.engine_mode
  engine_version          = var.engine_version
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  skip_final_snapshot     = var.skip_final_snapshot

  scaling_configuration {
    auto_pause               = var.scaling_conf_auto_pause
    min_capacity             = var.scaling_conf_min_capacity
    max_capacity             = var.scaling_conf_max_capacity
    seconds_until_auto_pause = var.scaling_conf_seconds_until_auto_pause
  }

  tags = {
    Name = var.cluster_identifier
  }
}

/* resource "aws_rds_cluster_instance" "aurora" {
  cluster_identifier = aws_rds_cluster.aurora.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.aurora.engine
  engine_version     = aws_rds_cluster.aurora.engine_version
} */