resource "aws_route_table" "module_aws_network_route_gateway" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${var.gateway_id}"
  }

  tags {
    Name        = "${var.tag_name}"
    Environment = "${var.tag_environment}"
    Description = "${var.tag_description}"
  }
}
