provider "aws" {
  region = "${var.region}"
}

resource "aws_key_pair" "module_aws_keys" {
  key_name   = "${var.key_name}"
  public_key = "${var.public_key}"
}
