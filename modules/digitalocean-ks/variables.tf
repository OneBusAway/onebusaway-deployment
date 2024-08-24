variable "do_token" {
  description = "DigitalOcean API token."
  type        = string
}

variable "region" {
  description = "The region in which the cluster will be created."
  default     = "nyc1"
  type        = string
}

variable "k8s_cluster_name" {
  description = "The name of the Kubernetes cluster."
  default     = "doks-cluster"
  type        = string
}

variable "k8s_version" {
  description = "The Kubernetes version to use for the cluster, grab the latest version slug from `doctl kubernetes options versions`."
  default     = "1.23.0-do.0"
  type        = string
}

variable "node_pool_name" {
  description = "The name of the node pool."
  default     = "default-pool"
  type        = string
}

variable "node_count" {
  description = "The initial number of nodes in the node pool."
  default     = 3
  type        = number
}

variable "vm_size" {
  description = "The size of the Droplet to use for nodes."
  default     = "s-2vcpu-4gb"
  type        = string
}

variable "node_tags" {
  description = "Tags to apply to the nodes."
  type        = list(string)
  default     = ["doks-node"]
}

variable "min_nodes" {
  description = "The minimum number of nodes in the node pool when autoscaling is enabled."
  default     = 1
  type        = number
}

variable "max_nodes" {
  description = "The maximum number of nodes in the node pool when autoscaling is enabled."
  default     = 5
  type        = number
}
