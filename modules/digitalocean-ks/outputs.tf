output "k8s_cluster_name" {
  value = digitalocean_kubernetes_cluster.main.name
}

output "k8s_cluster_endpoint" {
  value = digitalocean_kubernetes_cluster.main.endpoint
}

output "k8s_cluster_version" {
  value = digitalocean_kubernetes_cluster.main.version
}

output "k8s_cluster_region" {
  value = digitalocean_kubernetes_cluster.main.region
}
