output "vpc_public_subnets" {
  description = "IDs of the VPC's public subnets"
  value       = module.aws_vpc.public_subnets
}

output "ec2_instance_public_ip" {
  description = "Public IP addresse of EC2 instance"
  value       = module.ec2_instance.public_ip
}

output "webserver_url" {
  description = "The webserver public IP"
  value       = join("", ["http://", module.ec2_instance.public_ip[0]])
}