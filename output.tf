output "private_ip" {
  description = "This is the private IP for the SSH terminal"
  value = aws_instance.ec2_demo.private_ip
}