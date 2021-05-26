terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.42.0"
    }
  }

  required_version = "~> 0.14"
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "elliswu"

    workspaces {
      name = "terraform-bootcamp"
    }
  }
}
