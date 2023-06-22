// ------------------
//  Sagemaker Model
// ------------------

variable "model_name" {
  type    = string
  description = "The name of the model"
}

variable "execution_role_arn" {
  type    = string
  description = "A role that SageMaker can assume to access model artifacts and docker images for deployment"
}

variable "security_group_id" {
  type    = string
  description = "The ID of the security group"
}

variable "subnet_ids" {
  type    = list(string)
  description = "The list of subnet IDs"
}

variable "primary_container_image" {
  type    = string
  description = "The registry path where the inference code image is stored in Amazon ECR"
}

variable "primary_container_model_data_url" {
  type    = string
  description = "The URL for the S3 location where model artifacts are stored"
}

variable "primary_container_environment" {
  type    = map(string)
  description = "Envirnoment variables configuration"
  default = {}
}

// ------------------
//  Sagemaker endpoint configuration
// ------------------

variable "endpoint_config_name" {
  type    = string
  description = "The name of the endpoint configuration"
}

variable initial_instance_count {
  type        = number
  default     = 1
  description = "Initial number of instances used for auto-scaling"
}

variable "instance_type" {
  type    = string
  description = "The type of instance to start"
}

variable initial_variant_weight {
  type        = number
  default     = 1
  description = "Determines initial traffic distribution among all of the models that you specify in the endpoint configuration. If unspecified, it defaults to 1"
}

variable "device" {
  type            = string
  validation {
    condition     = contains(["cpu"], var.device)
    error_message = "Valid values for var: 'device' are (cpu)."
  }
  default         = "cpu"
}

variable "image_tag" {
  type    = string
  default = "latest"
}

// ------------------
//  Sagemaker endpoint
// ------------------

variable "endpoint_name" {
  type    = string
  description = "The name of the endpoint configuration"
}
