variable "admin_username" {
  description = "Administrator username for the virtual machine"
  type        = string
  default     = "adminuser"
}

variable "admin_password" {
  description = "Administrator password for the virtual machine"
  type        = string
  default     = "ComplexPassword#1234"
}

variable "caddy" {
  description = "Wheather to use Caddy or not, leave empty to disable"
  type        = string
  default     = "1"
}