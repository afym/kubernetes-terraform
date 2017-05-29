output "master" {
  value = "${aws_security_group.module_aws_network_security_master.id}"
}

output "node" {
  value = "${aws_security_group.module_aws_network_security_node.id}"
}
