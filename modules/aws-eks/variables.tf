variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The instance type to use for the managed node group"
  type        = string
  default     = "t3.medium"
}

variable "min_node_count" {
  description = "The minimum number of nodes in the node group"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "The maximum number of nodes in the node group"
  type        = number
  default     = 3
}

variable "node_count" {
  description = "The desired number of nodes in the node group"
  type        = number
  default     = 2
}