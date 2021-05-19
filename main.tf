provider "aws" {
  region = var.region
}

data "aws_ssm_parameter" "demo_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

module "vpc" {
  source = "./modules/vpc"
  region = var.region
}

resource "aws_instance" "ec2_demo" {
  ami           = data.aws_ssm_parameter.demo_ami.value
  instance_type = "t2.micro"
  subnet_id = module.vpc.subnet_id

  tags = {
    Name = "demo-vpc"
  }
}
