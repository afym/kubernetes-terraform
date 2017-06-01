provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc" "module_aws_network_vpc" {
  cidr_block = "${var.cidr_block}"

  tags {
    Name        = "${var.tag_name}"
    Description = "${var.tag_description}"
    Environment = "${var.tag_environment}"
  }
}
