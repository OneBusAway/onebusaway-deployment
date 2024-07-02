output "private_ip_address" {
  description = "The private IP address of the instance"
  value       = google_compute_instance.main.network_interface[0].network_ip
}

output "public_ip_address" {
  description = "The public IP address of the instance"
  value       = google_compute_address.main.address
}
