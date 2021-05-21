provider "aws" {
  region = "us-east-1"
}

resource "null_resource" "make_file" {
  provisioner "local-exec" {
    command = "echo '0' > test.txt"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo '6' > test.txt"
  }
}
