variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "vm_name" {
  description = "Name of the Droplet"
}

variable "region" {
  description = "DigitalOcean region"
}

variable "size" {
  description = "Droplet size"
}

variable "user" {
  description = "user name"
}

variable "caddy" {
  description = "Whether to use Caddy or not, leave empty to disable"
}