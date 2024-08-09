terraform {
  required_providers {
    render = {
      source = "registry.terraform.io/render-oss/render"
    }
  }
}

provider "render" {
  api_key  = var.api_key
  owner_id = var.owner_id
}

resource "render_web_service" "web" {
  name          = "OneBusAway API Server"
  plan          = var.plan
  region        = var.region
  num_instances = var.num_instances

  runtime_source = {
    image = {
      image_url = var.image_url
    }
  }

  disk = {
    name       = "Bundle"
    size_gb    = var.disk_size_gb
    mount_path = "/bundle"
  }

  env_vars = {
    "TZ"                    = { value = var.env_var_tz },
    "GTFS_URL"              = { value = var.env_var_gtfs_url },
    "VEHICLE_POSITIONS_URL" = { value = var.env_var_vehicle_positions_url },
    "TRIP_UPDATES_URL"      = { value = var.env_var_trip_updates_url },
    "ALERTS_URL"            = { value = var.env_var_alerts_url },
    "FEED_API_KEY"          = { value = var.env_var_feed_api_key },
    "FEED_API_VALUE"        = { value = var.env_var_feed_api_value },
    "REFRESH_INTERVAL"      = { value = var.env_var_refresh_interval },
    "AGENCY_ID"             = { value = var.env_var_agency_id },
    "JDBC_USER"             = { value = var.env_var_jdbc_user },
    "JDBC_PASSWORD"         = { value = var.env_var_jdbc_password },
    "JDBC_URL"              = { value = var.env_var_jdbc_url },
    "PORT"                  = { value = var.env_var_port }
  }

  health_check_path = "/onebusaway-api-webapp/api/where/current-time.json?key=org.onebusaway.iphone"
}

