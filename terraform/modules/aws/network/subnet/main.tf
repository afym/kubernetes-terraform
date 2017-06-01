provider "aws" {
  region = "${var.region}"
}

resource "aws_subnet" "module_aws_network_subnet" {
  vpc_id = "${var.vpc_id}"

  cidr_block        = "${var.cidr_block}"
  availability_zone = "${var.availability_zone}"

  tags {
    Name        = "${var.tag_name}"
    Description = "${var.tag_description}"
    Environment = "${var.tag_environment}"
  }
}
