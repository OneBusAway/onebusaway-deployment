output "ip_address" {
  description = "The private IP address of the instance"
  value       = azurerm_network_interface.main.private_ip_address
}

output "public_ip_address" {
  description = "The public IP address of the instance"
  value       = azurerm_public_ip.main.ip_address
}
