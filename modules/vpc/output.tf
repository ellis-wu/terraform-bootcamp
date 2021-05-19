output "vpc_id" {
  value = aws_vpc.demo_vpc.id
}

output "subnet_id" {
  value = aws_subnet.demo_subnet.id
}