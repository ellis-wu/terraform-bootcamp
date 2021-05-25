terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.42.0"
    }
  }

  backend "s3" {
    bucket = "my-terraform-lab"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
