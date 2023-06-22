// ------------------
//  Opensearch Domain
// ------------------

variable domain {
  type        = string
  description = "Name of the domain"
}

variable "engine_version" {
  type = string
  description = "The engine version for the Amazon OpenSearch Service domain"
}

# cluster_config

variable "instance_type" { 
  type = string
  description = "Instance type of data nodes in the cluster"
}

variable "instance_count" { 
  type = number
  description = "Number of instances in the cluster"
}

variable "dedicated_master_type" {
  type    = string
  default = null
  description = "Instance type of the dedicated main nodes in the cluster"
}

variable "dedicated_master_count" {
  type    = number
  default = 0
  description = "Number of dedicated main nodes in the cluster"
}

variable "dedicated_master_enabled" {
  type    = bool
  default = false
  description = "Whether dedicated main nodes are enabled for the cluster."
}

variable "zone_awareness_enabled" {
  type    = bool
  default = false
  description = "Whether zone awareness is enabled, set to true for multi-az deployment. To enable awareness with three Availability Zones, the availability_zone_count within the zone_awareness_config must be set to 3"
}

# encrypt_at_rest
# !!! 
#
# You can enable encrypt_at_rest in place for an existing, unencrypted domain only 
# if you are using OpenSearch or your Elasticsearch version is 6.7 or greater. For other versions,
# if you enable encrypt_at_rest, Terraform with recreate the domain, potentially causing data loss. 
# For any version, if you disable encrypt_at_rest for an existing, encrypted domain, Terraform will 
# recreate the domain, potentially causing data loss. If you change the kms_key_id, 
# Terraform will also recreate the domain, potentially causing data loss.

variable enable_encrypt_at_rest {
  type        = bool
  default     = false
  description = "Enable encryption at rest"
}

# domain_endpoint_options

variable enforce_https {
  type        = bool
  default     = true
  description = "Whether or not to require HTTPS"
}

variable tls_security_policy {
  type        = string
  default     = "Policy-Min-TLS-1-2-2019-07"
  description = "Name of the TLS security policy that needs to be applied to the HTTPS endpoint. Valid values: Policy-Min-TLS-1-0-2019-07 and Policy-Min-TLS-1-2-2019-07"
}

variable custom_endpoint_enabled {
  type        = bool
  description = "Whether to enable custom endpoint for the OpenSearch domain"
}

variable custom_endpoint_domain {
  type        = string
  default = ""
  description = "Fully qualified domain for your custom endpoint"
}

# ebs_options

variable "ebs_enabled" {
  type = bool
  description = "Whether EBS volumes are attached to data nodes in the domain"
}

variable "ebs_volume_size" {
  type = number
  default = 10
  description = "Size of EBS volumes attached to data nodes (in GiB)"
}

variable "volume_type" {
  type = string
  default = "gp3"
  description = "Type of EBS volumes attached to data nodes"
}

variable "throughput" {
  type = number
  default = 125
  description = "Specifies the throughput (in MiB/s) of the EBS volumes attached to data nodes. Applicable only for the gp3 volume type"
}

# node_to_node_encryption

variable enable_node_to_node_encryption {
  type        = bool
  default     = false
  description = "Whether to enable node-to-node encryption. If the node_to_node_encryption block is not provided then this defaults to false. Enabling node-to-node encryption of a new domain requires an engine_version of OpenSearch_X.Y or Elasticsearch_6.0 or greater"
}

# vpc_options

variable subnet_ids {
  type        = list(string)
  description = "List of subnet IDs"
}
