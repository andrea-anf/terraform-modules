variable "cluster_identifier" {
  type        = string
  description = "The cluster identifier"
}

variable "engine" {
  type        = string
  default     = "aurora-postgresql"
  description = "Name of the database engine to be used for this DB cluster. Valid Values: aurora-mysql, aurora-postgresql, mysql, postgres"
}

variable "engine_mode" {
  type        = string
  default     = "serverless"
  description = "Database engine mode. Valid values: global (only valid for Aurora MySQL 1.21 and earlier), multimaster, parallelquery, provisioned, serverless"
}

variable "engine_version" {
  type        = string
  default     = "13.6"
  description = "Database engine version. Updating this argument results in an outage"
}

variable "database_name" {
  type        = string
  default     = "mydatabase" # Modifica con il nome desiderato per il tuo database
  description = "Name for an automatically created database on cluster creation. There are different naming restrictions per database engine"
}

variable "master_username" {
  description = "Il nome utente dell'amministratore del database"
  type        = string
}

variable "master_password" {
  description = "La password dell'amministratore del database"
  type        = string
}

variable "backup_retention_period" {
  type        = number
  default     = 7
  description = "Days to retain backups for"
}

variable "preferred_backup_window" {
  type        = string
  default     = "02:00-03:00"
  description = "Daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC"
}

variable "scaling_conf_auto_pause" {
  type        = bool
  default     = true
  description = "Whether to enable automatic pause. A DB cluster can be paused only when it's idle (it has no connections). If a DB cluster is paused for more than seven days, the DB cluster might be backed up with a snapshot. In this case, the DB cluster is restored when there is a request to connect to it"
}

variable "scaling_conf_min_capacity" {
  type        = number
  default     = 2
  description = "Minimum capacity for an Aurora DB cluster in serverless DB engine mode. Valid Aurora PostgreSQL capacity values are 2, 4, 8, 16, 32, 64, 192, and 384"
}

variable "scaling_conf_max_capacity" {
  type        = number
  default     = 8
  description = "Maximum capacity for an Aurora DB cluster in serverless DB engine mode. Valid Aurora PostgreSQL capacity values are 2, 4, 8, 16, 32, 64, 192, and 384"
}

variable "scaling_conf_seconds_until_auto_pause" {
  type        = number
  default     = 300
  description = "Time, in seconds, before an Aurora DB cluster in serverless mode is paused. Valid values are 300 through 86400"
}

variable "skip_final_snapshot" {
  type        = bool
  default     = true
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted"
}
