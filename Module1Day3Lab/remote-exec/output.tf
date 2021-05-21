output "webserver_private_ip" {
  description = "This is the webserver ec2 private IP"
  value       = aws_instance.web_server.private_ip
}

output "webserver_public_ip" {
  description = "This is the webserver ec2 public IP"
  value       = aws_instance.web_server.public_ip
}

output "remote_exec_private_ip" {
  description = "This is the remote exec ec2 private IP"
  value       = aws_instance.remote_server.private_ip
}

output "remote_exec_public_ip" {
  description = "This is the remote exec ec2 public IP"
  value       = aws_instance.remote_server.public_ip
}

output "webserver_url" {
  description = "The webserver public IP"
  value       = join("", ["http://", aws_instance.web_server.public_ip])
}

output "remote_exec_webserver_url" {
  description = "The remote webserver public IP"
  value       = join("", ["http://", aws_instance.remote_server.public_ip])
}
