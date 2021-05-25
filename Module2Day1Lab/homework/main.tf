provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "aws_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "demo-vpc"
  cidr = "10.0.0.0/16"

  azs             = data.aws_availability_zones.available.names
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Owner       = "wu"
    Environment = "dev"
  }
}

module "aws_security_group" {
  source = "terraform-aws-modules/security-group/aws"
  name   = "demo_sg"
  vpc_id = module.aws_vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

data "aws_ssm_parameter" "demo_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

data "template_file" "user_data" {
  template = file("user_data.yml")
}

module "ec2_instance" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = "demo-ec2"
  ami                    = data.aws_ssm_parameter.demo_ami.value
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.aws_security_group.security_group_id]
  subnet_id              = module.aws_vpc.public_subnets[0]
  user_data              = data.template_file.user_data.rendered

  tags = {
    Owner       = "wu"
    Environment = "dev"
  }
}
