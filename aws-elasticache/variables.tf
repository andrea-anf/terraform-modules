# aws_elasticache_subnet_group
# See docs https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group

variable "subnet_group_name" {
  type        = string
  description = "The name of the ElastiCache subnet group"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = " List of VPC Subnet IDs for the cache subnet group"
}


# aws_elasticache_replication_group
# See docs https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group

variable "replication_group_name" {
  type        = string
  description = "The name of the ElastiCache replication group"
}

variable "replication_group_description" {
  type        = string
  description = "Description for the replication group. Must not be empty"
}

variable "security_group_id" {
  type        = string
  description = "The Security Group ID for the replication group"
}


variable "automatic_failover_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If enabled, num_cache_clusters must be greater than 1. Must be enabled for Redis (cluster mode enabled) replication groups. Defaults to false"
}

variable "num_cache_clusters" {
  type        = number
  default     = 0
  description = "Number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications. Conflicts with num_node_groups. Default to 0"
}

variable "num_node_groups" {
  type        = number
  default     = 1
  description = "Number of node groups (shards) for this Redis replication group. Mininum value 1"
}

variable "replicas_per_node_group" {
  type        = number
  default     = 0
  description = "Number of replica nodes in each node group, valid values are 0 to 5"
}

variable "apply_immediately" {
  type        = bool
  default     = true
  description = "Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is false"
}

variable "auto_minor_version_upgrade" {
  type        = bool
  default     = false
  description = "Specifies whether minor version engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Only supported for engine type 'redis' and if the engine version is 6 or higher. Defaults to false"
}

variable "engine_version" {
  type        = string
  default     = "5.0.6"
  description = "Version number of the cache engine to be used for the cache clusters in this replication group. If the version is 6 or higher, the major and minor version can be set, e.g. 6.2, or the minor version can be unspecified which will use the latest version at creation time, e.g. 6.x. Otherwise, specify the full version desired, e.g. 5.0.6"
}

variable "node_type" {
  type        = string
  default     = "cache.t2.small"
  description = "The instance class used"
}

variable "parameter_group_name" {
  type        = string
  default     = "default.redis7.cluster.on"
  description = "The name of the parameter group to associate with this cache cluster"
}

variable "at_rest_encryption_enabled" {
  type        = bool
  default     = true
  description = "Whether to enable encryption at rest"
}


# aws_cloudwatch_log_group 
# See docs https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group

variable "logs_expiration_days" {
  type        = number
  default     = 7
  description = "Specifies the number of days you want to retain log events in the specified log group"
}

variable "log_group_name" {
  type        = string
  description = "The name of the log groups created by the module"
}

variable "log_stream_name" {
  type        = string
  description = "The name of the log stream created by the module"
}



