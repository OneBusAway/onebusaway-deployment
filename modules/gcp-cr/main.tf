provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_cloud_run_v2_service" "main" {
  name     = var.service_name
  location = var.region

  template {
    scaling {
      max_instance_count = var.max_instance_count
    }

    volumes {
      name = "bundle"
    }

    containers {
      image = var.container_image

      volume_mounts {
        name       = "bundle"
        mount_path = "/bundle"
      }

      resources {
        limits = {
          memory = "4Gi"
          cpu    = "2"
        }
      }

      env {
        name  = "TZ"
        value = var.env_var_tz
      }
      env {
        name  = "GTFS_URL"
        value = var.env_var_gtfs_url
      }
      env {
        name  = "VEHICLE_POSITIONS_URL"
        value = var.env_var_vehicle_positions_url
      }
      env {
        name  = "TRIP_UPDATES_URL"
        value = var.env_var_trip_updates_url
      }
      env {
        name  = "ALERTS_URL"
        value = var.env_var_alerts_url
      }
      env {
        name  = "FEED_API_KEY"
        value = var.env_var_feed_api_key
      }
      env {
        name  = "FEED_API_VALUE"
        value = var.env_var_feed_api_value
      }
      env {
        name  = "REFRESH_INTERVAL"
        value = var.env_var_refresh_interval
      }
      env {
        name  = "AGENCY_ID"
        value = var.env_var_agency_id
      }
      env {
        name  = "JDBC_USER"
        value = var.env_var_jdbc_user
      }
      env {
        name  = "JDBC_PASSWORD"
        value = var.env_var_jdbc_password
      }
      env {
        name  = "JDBC_URL"
        value = var.env_var_jdbc_url
      }
      env {
        name  = "GOOGLE_MAPS_API_KEY"
        value = var.env_var_google_maps_api_key
      }
      env {
        name  = "GOOGLE_MAPS_CHANNEL_ID"
        value = var.env_var_google_maps_channel_id
      }
      env {
        name  = "GOOGLE_MAPS_CLIENT_ID"
        value = var.env_var_google_maps_client_id
      }
    }
  }
}

# Allow all users to access the service, since it's a public API
resource "google_cloud_run_v2_service_iam_binding" "noauth" {
  name     = google_cloud_run_v2_service.main.name
  location = google_cloud_run_v2_service.main.location


  role    = "roles/run.invoker"
  members = ["allUsers"]
}
