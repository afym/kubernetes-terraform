provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "module_aws_ec2" {
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  vpc_security_group_ids      = ["${var.vpc_security_group_ids}"]
  subnet_id                   = "${var.subnet_id}"
  private_ip                  = "10.0.1.100"
  user_data                   = "${var.user_data}"
  associate_public_ip_address = true
  source_dest_check           = false

  tags {
    Name        = "${var.tag_name}"
    Description = "${var.tag_description}"
    Environment = "${var.tag_environment}"
  }
}
