output "master_ip" {
  value = "${aws_instance.module_aws_ec2.private_ip}"
}
