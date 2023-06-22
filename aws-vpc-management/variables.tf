variable "default_tags" {
  type        = map(string)
  description = "Map with default tags"
}

variable "cidr_block" {
  type        = string
  description = "CIDR block to use for vpc"
}

variable "subnet_cidr_block" {
  type        = string
  description = "CIDR block to use for subnets"
}

variable "cidr_block_newbits" {
  type        = number
  default     = 4
  description = "newbits is the number of additional bits with which to extend the prefix. For example, if given a prefix ending in /16 and a newbits value of 4, the resulting subnet address will have length /20"
}

variable "cidr_block_netnum" {
  type        = number
  default     = 0
  description = "netnum is a whole number that can be represented as a binary integer with no more than newbits binary digits, which will be used to populate the additional bits added to the prefix"
}

variable "subnets_count" {
  type        = number
  default     = 1
  description = "The number of subnets"
}

variable "vpc_spoke_ids" {
  type        = list(string)
  description = "description"
}
