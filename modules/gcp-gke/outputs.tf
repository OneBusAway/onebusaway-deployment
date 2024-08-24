output "gke_cluster_name" {
  value = google_container_cluster.main.name
}

output "gke_cluster_endpoint" {
  value = google_container_cluster.main.endpoint
}

output "gke_cluster_master_version" {
  value = google_container_cluster.main.master_version
}

output "gke_cluster_location" {
  value = google_container_cluster.main.location
}
