output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "frontend_url" {
  description = "URL for the frontend application"
  value       = "http://${aws_instance.app_server.public_ip}:3000"
}

output "backend_url" {
  description = "URL for the backend application"
  value       = "http://${aws_instance.app_server.public_ip}:5000"
} 