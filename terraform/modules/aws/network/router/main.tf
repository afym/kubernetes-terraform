resource "aws_route_table" "module_aws_network_route_gateway" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${var.gateway_id}"
  }

  tags {
    Name        = "kubernetes-route-gateway"
    Environment = "test"
    Description = "Kubernetes's route table for public subnet"
  }
}

resource "aws_route_table" "module_aws_network_route_nat" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${var.nat_gateway_id}"
  }

  tags {
    Name        = "kubernetes-route-nat"
    Environment = "test"
    Description = "Kubernetes's route table for private subnet"
  }
}
