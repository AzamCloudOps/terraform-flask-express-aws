output "flask_server_ip" {
  description = "Public IP address of the Flask EC2 instance"
  value       = aws_instance.flask_server.public_ip
}

output "express_server_ip" {
  description = "Public IP address of the Express EC2 instance"
  value       = aws_instance.express_server.public_ip
}

output "frontend_url" {
  description = "URL for the Express frontend application"
  value       = "http://${aws_instance.express_server.public_ip}:3000"
}

output "backend_url" {
  description = "URL for the Flask backend application"
  value       = "http://${aws_instance.flask_server.public_ip}:5000"
}
