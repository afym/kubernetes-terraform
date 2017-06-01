provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "module_aws_ec2" {
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  vpc_security_group_ids      = ["${var.vpc_security_group_ids}"]
  subnet_id                   = "${var.subnet_id}"
  associate_public_ip_address = true
  source_dest_check           = false

  connection {
    user        = "ec2-user"
    private_key = "${var.private_key}"
    agent       = false
  }

  provisioner "file" {
    source      = "${var.provisioner_source}"
    destination = "/tmp/provisioner.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir /scripts",
      "sudo mv /tmp/provisioner.sh /scripts/provisioner.sh",
      "chmod +x /scripts/provisioner.sh",
      "sudo /scripts/provisioner.sh",
    ]
  }

  tags {
    Name        = "${var.tag_name}"
    Description = "${var.tag_description}"
    Environment = "${var.tag_environment}"
  }
}
