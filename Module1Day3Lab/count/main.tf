provider "aws" {
  region = var.region
}

data "aws_ssm_parameter" "demo_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "server" {
  ami           = data.aws_ssm_parameter.demo_ami.value
  instance_type = "t2.micro"
  count         = 2
  tags = {
    Name = "${count.index}"
  }
}

output "instance_ips" {
  value = aws_instance.server[*].private_ip
  description = "The private IP address of the server instances"
}
