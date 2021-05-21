provider "aws" {
  region = var.region
}

data "aws_ssm_parameter" "cathay_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

module "vpc" {
  source = "./modules/vpc"
}

module "s3" {
  source = "./modules/s3"
}

resource "aws_security_group" "demo_sg" {
  vpc_id = module.vpc.vpc_id
  name   = join("_", ["sg", module.vpc.vpc_id])
  dynamic "ingress" {
    for_each = var.sg_rules
    content {
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["proto"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "demo-sg"
  }

  depends_on = [
    module.vpc.vpc_id
  ]
}

resource "aws_key_pair" "public_key" {
  key_name   = "demo-keypair"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "remote_server" {
  ami               = data.aws_ssm_parameter.cathay_ami.value
  instance_type     = "t2.micro"
  subnet_id         = module.vpc.subnet_id
  security_groups   = [aws_security_group.demo_sg.id]
  availability_zone = "us-east-1a"
  key_name          = aws_key_pair.public_key.id

  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install httpd",
      "sudo systemctl start httpd && sudo systemctl enable httpd",
      "echo '<h1><center>Terraform Bootcamp Moduel 1 Day3 Lab</center></h1>' > index.html",
      "sudo mv index.html /var/www/html/"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  tags = {
    Name = "demo-webserver"
  }
}
