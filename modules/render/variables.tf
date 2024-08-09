variable "api_key" {
  description = "API key for Render"
  type        = string
}

variable "owner_id" {
  description = "Owner ID"
  type        = string
}

variable "region" {
  description = "Region to deploy the service"
  type        = string
  default     = "oregon"
}

variable "plan" {
  description = "Service plan"
  type        = string
  default     = "starter"
}

variable "num_instances" {
  description = "Number of instances"
  type        = number
  default     = 1
}

variable "image_url" {
  description = "Image URL"
  type        = string
  default     = "opentransitsoftwarefoundation/onebusaway-api-webapp:2.4.18-cs-v1.3.0"
}

variable "disk_size_gb" {
  description = "Disk size in GB"
  type        = number
  default     = 1
}

variable "env_var_tz" {
  description = "Timezone"
  type        = string
}

variable "env_var_gtfs_url" {
  description = "GTFS URL"
  type        = string
}

variable "env_var_vehicle_positions_url" {
  description = "Vehicle positions URL"
  type        = string
}

variable "env_var_trip_updates_url" {
  description = "Trip updates URL"
  type        = string
}

variable "env_var_alerts_url" {
  description = "Alerts URL"
  type        = string
}

variable "env_var_feed_api_key" {
  description = "Feed API Key"
  type        = string
}

variable "env_var_feed_api_value" {
  description = "Feed API Value"
  type        = string
}

variable "env_var_refresh_interval" {
  description = "Refresh interval"
  type        = number
  default     = 30
}

variable "env_var_agency_id" {
  description = "Agency ID"
  type        = string
}

variable "env_var_jdbc_user" {
  description = "JDBC User"
  type        = string
}

variable "env_var_jdbc_password" {
  description = "JDBC Password"
  type        = string
}

variable "env_var_jdbc_url" {
  description = "JDBC URL"
  type        = string
}

variable "env_var_port" {
  description = "Port"
  type        = number
  default     = 8080
}
