terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.digitalocean_token
}

resource "digitalocean_app" "main" {
  spec {
    name   = "onebusaway-api-server"
    region = var.region

    service {
      name = "onebusaway-api-webapp"
      image {
        registry_type = "DOCKER_HUB"
        registry      = "opentransitsoftwarefoundation"
        repository    = "onebusaway-api-webapp"
        tag           = "2.5.12-cs-v1.0.0"
      }
      instance_size_slug = var.instance_size_slug
      instance_count     = var.num_instances

      env {
        key   = "TZ"
        value = var.env_var_tz
        scope = "RUN_AND_BUILD_TIME"
      }
      env {
        key   = "GTFS_URL"
        value = var.env_var_gtfs_url
        scope = "RUN_AND_BUILD_TIME"
      }
      env {
        key   = "VEHICLE_POSITIONS_URL"
        value = var.env_var_vehicle_positions_url
        scope = "RUN_AND_BUILD_TIME"
      }
      env {
        key   = "TRIP_UPDATES_URL"
        value = var.env_var_trip_updates_url
        scope = "RUN_AND_BUILD_TIME"
      }
      env {
        key   = "ALERTS_URL"
        value = var.env_var_alerts_url
        scope = "RUN_AND_BUILD_TIME"
      }
      env {
        key   = "FEED_API_KEY"
        value = var.env_var_feed_api_key
        scope = "RUN_AND_BUILD_TIME"
      }
      env {
        key   = "FEED_API_VALUE"
        value = var.env_var_feed_api_value
        scope = "RUN_AND_BUILD_TIME"
      }
      env {
        key   = "REFRESH_INTERVAL"
        value = var.env_var_refresh_interval
        scope = "RUN_AND_BUILD_TIME"
      }
      env {
        key   = "AGENCY_ID"
        value = var.env_var_agency_id
        scope = "RUN_AND_BUILD_TIME"
      }
      env {
        key   = "JDBC_USER"
        value = var.env_var_jdbc_user
        scope = "RUN_AND_BUILD_TIME"
      }
      env {
        key   = "JDBC_PASSWORD"
        value = var.env_var_jdbc_password
        scope = "RUN_AND_BUILD_TIME"
      }
      env {
        key   = "JDBC_URL"
        value = var.env_var_jdbc_url
        scope = "RUN_AND_BUILD_TIME"
      }
      env {
        key   = "PORT"
        value = var.env_var_port
        scope = "RUN_AND_BUILD_TIME"
      }

      http_port = var.env_var_port

      health_check {
        http_path = "/onebusaway-api-webapp/api/where/current-time.json?key=org.onebusaway.iphone"
        port      = var.env_var_port
      }
    }
  }
}
