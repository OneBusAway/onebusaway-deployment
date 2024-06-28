output "private_ip" {
  value       = aws_instance.main.private_ip
  description = "The private IP address of the EC2 instance."
}

output "public_ip" {
  value       = aws_instance.main.public_ip
  description = "The public IP address of the EC2 instance."
}
