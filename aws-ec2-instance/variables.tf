variable "ami_id" {
  type        = string
  description = "EC2 instance AMI ID"
}

variable "instance_name" {
  type        = string
  description = "EC2 instance name"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Type of the Instance"
}

variable "subnet_id" {
  type        = string
  description = "The subnet ID where to deploy the instance"
}

variable "security_group_id" {
  type        = string
  description = "The Security Group ID to attach to the instance"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address to the EC2 instance"
  default     = true
}

variable "data_volume_type" {
  type        = string
  description = "Volume type of data volume"
  default     = "gp2"
}

variable "data_volume_size" {
  type        = string
  description = "Volume size of data volume"
  default     = "10"
}

variable "data_volume_delete_on_termination" {
  type        = bool
  default     = true
  description = "Whether the volume should be destroyed on instance termination"
}

variable "data_volume_encrypted" {
  type        = bool
  default     = true
  description = "Whether to enable volume encryption"
}