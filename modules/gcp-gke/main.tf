provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_container_cluster" "main" {
  name                = var.gke_cluster_name
  location            = var.region
  deletion_protection = false # Allows Terraform to delete the GKE cluster

  node_pool {
    name       = var.node_pool_name
    node_count = var.node_count

    node_config {
      machine_type = var.vm_size
      tags         = var.node_tags
      disk_size_gb = var.disk_size_gb
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform",
      ]
    }

    management {
      auto_upgrade = true
      auto_repair  = true
    }
  }

  network_policy {
    enabled = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
