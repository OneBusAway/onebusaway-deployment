variable "project_id" {
  description = "The ID of the GCP project."
  type        = string
}

variable "region" {
  description = "The location (region or zone) in which the cluster master will be created, as well as the default node location. "
  default     = "us-central1-a"
  type        = string
}

variable "gke_cluster_name" {
  description = "The name of the GKE cluster."
  default     = "gke-cluster"
  type        = string
}

variable "node_pool_name" {
  description = "The name of the node pool."
  default     = "default-pool"
  type        = string
}

variable "node_count" {
  description = "The number of nodes in the node pool."
  default     = 3
  type        = number
}

variable "vm_size" {
  description = "The machine type of the Virtual Machine."
  default     = "e2-medium"
  type        = string
}

variable "node_tags" {
  description = "Tags to apply to the nodes"
  type        = list(string)
  default     = ["gke-node"]
}

variable "disk_size_gb" {
  description = "The size of the disk in GB"
  type        = number
  default     = 100
}