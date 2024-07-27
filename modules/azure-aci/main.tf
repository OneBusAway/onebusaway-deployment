provider "azurerm" {
  features {}
}

locals {
  liveness_probe_path                  = "/onebusaway-api-webapp/api/where/current-time.json?key=org.onebusaway.iphone"
  liveness_probe_port                  = 8080
  liveness_probe_initial_delay_seconds = 120
  liveness_probe_period_seconds        = 30
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  #   tags = var.tags
}

resource "azurerm_storage_share" "main" {
  name                 = var.storage_share_name
  storage_account_name = azurerm_storage_account.main.name
  quota                = var.storage_share_quota

  depends_on = [
    azurerm_storage_account.main
  ]
}


resource "azurerm_container_group" "main" {
  name                = var.container_group_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  os_type             = "Linux"

  container {
    name   = var.container_name
    image  = var.container_image
    cpu    = var.container_cpu
    memory = var.container_memory

    environment_variables = {
      TZ                     = var.env_var_tz
      GTFS_URL               = var.env_var_gtfs_url
      VEHICLE_POSITIONS_URL  = var.env_var_vehicle_positions_url
      TRIP_UPDATES_URL       = var.env_var_trip_updates_url
      ALERTS_URL             = var.env_var_alerts_url
      REFRESH_INTERVAL       = var.env_var_refresh_interval
      AGENCY_ID              = var.env_var_agency_id
      FEED_API_KEY           = var.env_var_feed_api_key
      FEED_API_VALUE         = var.env_var_feed_api_value
      JDBC_USER              = var.env_var_jdbc_user
      JDBC_PASSWORD          = var.env_var_jdbc_password
      JDBC_URL               = var.env_var_jdbc_url
      GOOGLE_MAPS_API_KEY    = var.env_var_google_maps_api_key
      GOOGLE_MAPS_CHANNEL_ID = var.env_var_google_maps_channel_id
      GOOGLE_MAPS_CLIENT_ID  = var.env_var_google_maps_client_id
    }

    ports {
      port     = "8080"
      protocol = "TCP"
    }

    volume {
      name                 = "bundle"
      mount_path           = "/bundle"
      read_only            = false
      share_name           = azurerm_storage_share.main.name
      storage_account_name = azurerm_storage_account.main.name
      storage_account_key  = azurerm_storage_account.main.primary_access_key
    }

    liveness_probe {
      http_get {
        path = local.liveness_probe_path
        port = local.liveness_probe_port
      }
      initial_delay_seconds = local.liveness_probe_initial_delay_seconds
      period_seconds        = local.liveness_probe_period_seconds
    }
  }
}
