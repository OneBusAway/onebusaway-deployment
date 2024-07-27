variable "project_id" {
  description = "The ID of the project in which to create the resources."
  type        = string
}

variable "max_instance_count" {
  description = "The maximum number of instances that the service should scale up to."
  type        = number
  default     = 1
}

variable "region" {
  description = "The region of the resources."
  type        = string
  default     = "us-central1"
}

variable "service_name" {
  description = "The name of the Cloud Run service."
  type        = string
  default     = "onebusaway-api"
}

variable "container_image" {
  description = "Docker image for the container, expected an image path like [host/]repo-path[:tag and/or @digest], where host is one of [region.]gcr.io, [region-]docker.pkg.dev or docker.io"
  type        = string
  default     = "opentransitsoftwarefoundation/onebusaway-api-webapp:2.5.12-cs-v1.0.0"
}

variable "env_var_tz" {
  description = "Environment variable TZ"
  type        = string
  default     = "America/Toronto"
}

variable "env_var_gtfs_url" {
  description = "Environment variable GTFS_URL"
  type        = string
  default     = "https://api.cityofkingston.ca/gtfs/gtfs.zip"
}

variable "env_var_vehicle_positions_url" {
  description = "Environment variable VEHICLE_POSITIONS_URL"
  type        = string
  default     = "https://api.cityofkingston.ca/gtfs-realtime/vehicleupdates.pb"
}

variable "env_var_trip_updates_url" {
  description = "Environment variable TRIP_UPDATES_URL"
  type        = string
  default     = "https://api.cityofkingston.ca/gtfs-realtime/tripupdates.pb"
}

variable "env_var_alerts_url" {
  description = "Environment variable ALERTS_URL"
  type        = string
  default     = "https://api.cityofkingston.ca/gtfs-realtime/alerts.pb"
}

variable "env_var_feed_api_key" {
  description = "Environment variable FEED_API_KEY"
  type        = string
  default     = ""
}

variable "env_var_feed_api_value" {
  description = "Environment variable FEED_API_VALUE"
  type        = string
  default     = ""
}

variable "env_var_refresh_interval" {
  description = "Environment variable REFRESH_INTERVAL"
  type        = string
  default     = "30"
}

variable "env_var_agency_id" {
  description = "Environment variable AGENCY_ID"
  type        = string
  default     = "0"
}

variable "env_var_jdbc_user" {
  description = "Environment variable JDBC_USER"
  type        = string
  default     = "oba_user"
}

variable "env_var_jdbc_password" {
  description = "Environment variable JDBC_PASSWORD"
  type        = string
  default     = "oba_password"
}

variable "env_var_jdbc_url" {
  description = "Environment variable JDBC_URL"
  type        = string
  default     = "jdbc:mysql://<DATABASE_HOST>:<PORT>/oba_database"
}

variable "env_var_google_maps_api_key" {
  description = "Environment variable GOOGLE_MAPS_API_KEY"
  type        = string
  default     = ""
}

variable "env_var_google_maps_channel_id" {
  description = "Environment variable GOOGLE_MAPS_CHANNEL_ID"
  type        = string
  default     = ""
}

variable "env_var_google_maps_client_id" {
  description = "Environment variable GOOGLE_MAPS_CLIENT_ID"
  type        = string
  default     = ""
}
