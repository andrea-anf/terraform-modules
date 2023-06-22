variable "subnet_ids" {
  type        = list(string)
  description = "Subnets associated with the task or service."
}

// ------------------
//  ECS Service
// ------------------

variable "service_name" {
  type        = string
  description = "The name of the service"
}

variable "cluster_name" {
  type        = string
  description = "The ECS cluster name"
}

variable "launch_type" {
  type        = string
  default     = "EC2"
  description = "Launch type on which to run your service. The valid values are EC2, FARGATE, and EXTERNAL. Defaults to EC2"
}

variable "container_image" {
  type        = string
  default     = "centos:latest"
  description = "The image to use for containers"
}

variable "container_port" {
  type        = number
  default     = 8000
  description = "The port number used by containers to communicate with the outside"
}

variable "ecs_service_desired_count" {
  type        = number
  default     = 1
  description = "Number of instances of the task definition to place and keep running"
}
variable "lb_target_group_arn" {
  type        = string
  description = "The ARN of the target group pointing to ECS"
}

// ------------------
//  ECS Task Definition
// ------------------

variable "container_name" {
  type        = string
  description = "The name of the container"
}

variable "network_mode" {
  type        = string
  default     = "awsvpc"
  description = "Docker networking mode to use for the containers in the task. Valid values are none, bridge, awsvpc, and host"
}

variable "cpu" {
  type        = number
  default     = 256
  description = "Number of cpu units used by the task"
}

variable "memory" {
  type        = number
  default     = 512
  description = "Amount (in MiB) of memory used by the task"
}

variable "host_port" {
  type        = number
  default     = 8000
  description = "The port number used by host to communicate with the outside"
}

variable "iam_role_arn" {
  type        = string
  description = "The IAM role ARN"
}


// ------------------
//  Security Group
// ------------------

/* variable lb_security_group_ids  {
  type        = list(string)
  description = "The list of security group IDs of internal ALB"
} */

variable "security_group_id" {
  type        = string
  description = "The Security Group ID for the ECS service"
}

// ------------------
//  AppAutoScaling
// ------------------

variable "max_capacity" {
  type        = number
  description = "Max capacity of the scalable target"
}

variable "min_capacity" {
  type        = number
  description = "Min capacity of the scalable target"
}

variable "target_value" {
  type        = number
  description = "Target value for the metric"
}

variable "scale_in_cooldown" {
  type        = number
  description = "Amount of time, in seconds, after a scale in activity completes before another scale in activity can start"
}

variable "scale_out_cooldown" {
  type        = number
  description = "Amount of time, in seconds, after a scale out activity completes before another scale out activity can start"
}

variable "predefined_metric_type" {
  type        = string
  description = "Metric type"
}

// ------------------
//  CloudWatch Log group
// ------------------

variable "logs_expiration_days" {
  type        = number
  default     = 7
  description = "Specifies the number of days you want to retain log events in the specified log group"
}
