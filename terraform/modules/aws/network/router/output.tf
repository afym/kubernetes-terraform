output "gateway" {
  value = "${aws_route_table.module_aws_network_route_gateway.id}"
}

output "nat" {
  value = "${aws_route_table.module_aws_network_route_nat.id}"
}
