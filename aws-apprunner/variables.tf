variable "name" {
  type        = string
  description = "The name of the AppRunner Service"
}

variable "image_port" {
  type        = string
  default     = "8000"
  description = "Port that your application listens to in the container"
}

variable "image_identifier" {
  type        = string
  description = " Identifier of an image. For an image in ECR, this is an image name"
}

variable "image_repository_type" {
  type        = string
  default     = "ECR"
  description = " Type of the image repository. This reflects the repository provider and whether the repository is private (ECR) or public (ECR_PUBLIC)"
}

variable "auto_deployments_enabled" {
  type        = bool
  default     = false
  description = "Whether continuous integration from the source repository is enabled for the App Runner service. If set to true, each repository change (source code commit or new image version) starts a deployment"
}

variable "max_concurrency" {
  type        = number
  default     = 50
  description = "Maximal number of concurrent requests that you want an instance to process. When the number of concurrent requests goes over this limit, App Runner scales up your service"
}

variable "max_size" {
  type        = number
  default     = 10
  description = " Maximal number of instances that App Runner provisions for your service"
}

variable "min_size" {
  type        = number
  default     = 2
  description = " Minimal number of instances that App Runner provisions for your service"
}
