provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "module_aws_ec2" {
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.key_name}"
  subnet_id              = "${var.subnet_id}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  user_data              = "${var.user_data}"

  tags {
    Name        = "${var.tag_name}"
    Description = "${var.tag_description}"
    Environment = "${var.tag_environment}"
  }
}
