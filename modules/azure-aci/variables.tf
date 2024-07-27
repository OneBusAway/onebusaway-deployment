variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "container_group_name" {
  description = "The name of the container group"
  type        = string
}

variable "container_name" {
  description = "The name of the container"
  type        = string
}

variable "container_image" {
  description = "Docker image for the container"
  type        = string
}

variable "container_cpu" {
  description = "The number of CPU units for the container"
  type        = number
}

variable "container_memory" {
  description = "The amount of memory for the container"
  type        = number
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "storage_share_name" {
  description = "The name of the storage share"
  type        = string
}

variable "storage_share_quota" {

  description = "The quota for the storage share, in GB"
  type        = number
}

variable "env_var_tz" {
  description = "Environment variable TZ"
  type        = string
}

variable "env_var_gtfs_url" {
  description = "Environment variable GTFS_URL"
  type        = string
}

variable "env_var_vehicle_positions_url" {
  description = "Environment variable VEHICLE_POSITIONS_URL"
  type        = string
}

variable "env_var_trip_updates_url" {
  description = "Environment variable TRIP_UPDATES_URL"
  type        = string
}

variable "env_var_alerts_url" {
  description = "Environment variable ALERTS_URL"
  type        = string
}

variable "env_var_feed_api_key" {
  description = "Environment variable FEED_API_KEY"
  type        = string
}

variable "env_var_feed_api_value" {
  description = "Environment variable FEED_API_VALUE"
  type        = string
}

variable "env_var_refresh_interval" {
  description = "Environment variable REFRESH_INTERVAL"
  type        = string
}

variable "env_var_agency_id" {
  description = "Environment variable AGENCY_ID"
  type        = string
}

variable "env_var_jdbc_user" {
  description = "Environment variable JDBC_USER"
  type        = string
}

variable "env_var_jdbc_password" {
  description = "Environment variable JDBC_PASSWORD"
  type        = string
}

variable "env_var_jdbc_url" {
  description = "Environment variable JDBC_URL"
  type        = string
}

variable "env_var_google_maps_api_key" {
  description = "Environment variable GOOGLE_MAPS_API_KEY"
  type        = string
}

variable "env_var_google_maps_channel_id" {
  description = "Environment variable GOOGLE_MAPS_CHANNEL_ID"
  type        = string
}

variable "env_var_google_maps_client_id" {
  description = "Environment variable GOOGLE_MAPS_CLIENT_ID"
  type        = string
}



