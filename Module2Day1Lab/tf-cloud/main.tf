provider "aws" {
  region = "us-east-1"
}

module "ec2_with_mandatory_tagging" {
  source = "github.com/cloudtp/hello-terraform-module"
  Name    = "tf-bootcamp"
  EndDate = "2021/05/25"
  user_id = "wu"
}
