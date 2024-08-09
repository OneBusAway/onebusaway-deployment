variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "vm_name" {
  description = "Name of the Droplet"
  type        = string
}

variable "region" {
  description = "DigitalOcean region"
  type        = string
}

variable "size" {
  description = "Droplet size"
  type        = string
}

variable "user" {
  description = "user name"
  type        = string
}

variable "caddy" {
  description = "Whether to use Caddy or not, leave empty to disable"
  type        = string
}