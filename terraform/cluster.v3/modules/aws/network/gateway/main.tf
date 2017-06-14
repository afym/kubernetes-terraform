provider "aws" {
  region = "${var.region}"
}

resource "aws_internet_gateway" "module_aws_network_gateway" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name        = "${var.tag_name}"
    Description = "${var.tag_description}"
    Environment = "${var.tag_environment}"
  }
}
