variable "admin_username" {
  description = "Administrator username for the virtual machine"
  type        = string
  default     = "adminuser"
}

variable "size" {
  description = "The size of the virtual machine, you can find details here: https://cloudprice.net/vm/Standard_B2s"
  type        = string
  default     = "Standard_B2s"
}

variable "caddy" {
  description = "Whether to use Caddy or not, leave empty to disable"
  type        = string
  default     = "1"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "OneBusAway"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "vnet_name" {
  description = "Virtual Network name"
  type        = string
  default     = "myVNet"
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = "mySubnet"
}

variable "public_ip_name" {
  description = "Public IP name"
  type        = string
  default     = "myPublicIP"
}

variable "nsg_name" {
  description = "Network Security Group name"
  type        = string
  default     = "myNSG"
}

variable "nic_name" {
  description = "Network Interface name"
  type        = string
  default     = "myNIC"
}

variable "vm_name" {
  description = "Virtual Machine name"
  type        = string
  default     = "OBA"
}