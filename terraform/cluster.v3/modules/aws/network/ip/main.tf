provider "aws" {
  region = "${var.region}"
}

resource "aws_eip" "module_aws_network_ip" {
  vpc = true
}
