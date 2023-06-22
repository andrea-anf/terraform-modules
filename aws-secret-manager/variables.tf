variable name {
  type        = string
  description = "The name of the secret, The secret name can consist of uppercase letters, lowercase letters, digits, and any of the following characters: /_+=.@- Conflicts with name_prefix"
}

variable secret_string {
  type        = string
  description = "Specifies text data that you want to encrypt and store in this version of the secret. This is required if secret_binary is not set"
}

variable enable_rotation {
  type        = bool
  default     = false
  description = "Define if enable secret rotation"
}

variable rotation_lambda_arn {
  type        = string
  default     = ""
  description = "Specifies the ARN of the Lambda function that can rotate the secret"
}

variable automatically_after_days {
  type        = number
  default     = 30
  description = "Specifies the number of days between automatic scheduled rotations of the secret"
}
