provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = "cathay-terraform-bootcamp-demo"
  acl = "private"

  tags = {
    Name = "demo-bucket"
  }
}
