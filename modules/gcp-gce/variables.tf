variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "seventh-fact-210601"
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-east1"
}

variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-east1-b"
}

variable "admin_username" {
  description = "Administrator username for the virtual machine"
  type        = string
  default     = "adminuser"
}


variable "machine_type" {
  description = "The machine type for the virtual machine, you can find details here: https://cloudprice.net/gcp/compute/instances/e2-medium"
  type        = string
  default     = "e2-medium"
}

variable "caddy" {
  description = "Whether to use Caddy or not, leave empty to disable"
  type        = string
  default     = "1"
}

variable "network_name" {
  description = "Network name"
  type        = string
  default     = "onebusaway-network"
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = "onebusaway-subnet"
}

variable "public_ip_name" {
  description = "Public IP name"
  type        = string
  default     = "onebusaway-public-ip"
}

variable "firewall_name" {
  description = "Firewall rule name"
  type        = string
  default     = "onebusaway-firewall"
}

variable "vm_name" {
  description = "Virtual Machine name"
  type        = string
  default     = "onebusaway-vm"
}
