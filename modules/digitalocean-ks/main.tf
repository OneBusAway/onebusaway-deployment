terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_kubernetes_cluster" "main" {
  name    = var.k8s_cluster_name
  region  = var.region
  version = var.k8s_version

  node_pool {
    name       = var.node_pool_name
    size       = var.vm_size
    node_count = var.node_count

    tags = var.node_tags

    auto_scale = true
    min_nodes  = var.min_nodes
    max_nodes  = var.max_nodes
  }

  lifecycle {
    create_before_destroy = true
  }
}
