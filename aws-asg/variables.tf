variable "name" {
  type        = string
  description = "The name of the ASG"
}

variable "launch_template_name" {
  type        = string
  description = "The name of the launch template created by the module"
}

variable "ecs_capacity_provider_name" {
  type        = string
  description = "The name of the ECS capacity provider created by the module"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs"
}

variable "root_volume_size" {
  type        = number
  description = "The size of the root volume in gigabytes"
}

variable "image_owner_ids" {
  type        = list(string)
  description = "List of image owner IDs"
}

variable "launch_template_instance_type" {
  type        = string
  description = "the instance type of the ec2 instances that will run the docker pod."
}

variable "launch_template_security_group_id" {
  type        = string
  description = "the securitygroup id of the ec2 instances that will run the docker pod."
}

variable "autoscaling_desired_capacity" {
  type        = number
  description = "the target capacity of the autoscaling group for this docker service"
}

variable "autoscaling_max_size" {
  type        = number
  description = "the maximum capacity of the autoscaling group for this docker service."
}

variable "autoscaling_min_size" {
  type        = number
  description = "the minimum capacity of the autoscaling group for this docker service."
}

variable "autoscaling_health_check_grace_period" {
  type        = number
  description = "the health grace period that the ec2 instance start plus docker start may take."
}

variable "autoscaling_launch_template_version" {
  type        = string
  description = "the auto scaling launch template version that will be used in the autoscaling. Only use this for debugging purpose."
}

variable "autoscaling_protect_from_scale_in" {
  type        = bool
  description = "if protect_from_scale_in is enabled on the aws_autoscaling_group in case enable_managed_scaling is set to true"
}

variable "autoscaling_force_delete" {
  type        = bool
  default     = true
  description = "description"
}

variable "managed_scaling_maximum_scaling_step_size" {
  type        = number
  description = "the capacity provider maximum scaling step size"
}

variable "managed_scaling_minimum_scaling_step_size" {
  type        = number
  description = "the capacity provider minimum scaling step size"
}

variable "managed_scaling_target_capacity" {
  type        = number
  description = "the capacity provider target capacity"
}

variable "cluster_name" {
  type        = string
  description = "ECS cluster name"
}

variable "scope" {
  type        = string
  description = "AWS scope"
}

variable "stage" {
  type        = string
  description = "AWS stage"
}

