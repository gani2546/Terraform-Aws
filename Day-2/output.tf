output "name" {
  description = "The public IP or DNS of the AWS instance"
  value       = aws_instance.name.public_ip
}
