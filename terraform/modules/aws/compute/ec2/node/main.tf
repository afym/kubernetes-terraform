provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "module_aws_ec2" {
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]

  connection {
    user        = "ec2-user"
    private_key = "${var.private_key}"
    agent       = false
  }

  provisioner "local-exec" {
    command = "echo ${var.master_ip} >> ${var.master_ip_source}"
  }

  provisioner "file" {
    source      = "${var.provisioner_source}"
    destination = "/tmp/provisioner.sh"
  }

  provisioner "file" {
    source      = "${var.master_ip_source}"
    destination = "/tmp/master.ip.config"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir /scripts",
      "sudo mv /tmp/provisioner.sh /scripts/provisioner.sh",
      "sudo mv /tmp/master.ip.config /scripts/master.ip.config",
      "chmod +x /scripts/provisioner.sh",
      "sudo /scripts/provisioner.sh",
    ]
  }

  provisioner "local-exec" {
    command = "rm -rf ${var.master_ip_source}"
  }

  tags {
    Name        = "${var.tag_name}"
    Description = "${var.tag_description}"
    Environment = "${var.tag_environment}"
  }
}
