variable "location" {
  description = "The location where the resources will be created."
  default     = "East US"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  default     = "aks-rg"
  type        = string
}

variable "aks_cluster_name" {
  description = "The name of the AKS cluster."
  default     = "aks-cluster"
  type        = string
}

variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster."
  default     = "aks"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    environment = "dev"
  }
}
