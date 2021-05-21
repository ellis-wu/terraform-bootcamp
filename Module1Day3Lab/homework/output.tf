output "private_ip" {
  description = "This is the ec2 private IP"
  value       = aws_instance.remote_server.private_ip
}

output "public_ip" {
  description = "This is the ec2 public IP"
  value       = aws_instance.remote_server.public_ip
}

output "webserver url" {
  description = "The webserver public IP"
  value       = join("", ["http://", aws_instance.remote_server.public_ip])
}
