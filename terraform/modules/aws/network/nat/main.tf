provider "aws" {
  region = "${var.region}"
}

resource "aws_nat_gateway" "module_aws_network_nat" {
  allocation_id = "${var.allocation_id}"
  subnet_id     = "${var.subnet_id}"
}
