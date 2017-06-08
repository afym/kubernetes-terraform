provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "master_aws_ec2" {
  ami                    = "${var.master_ami}"
  instance_type          = "${var.master_instance_type}"
  key_name               = "${module.kubernetes_private_key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.master_aws_security_group.id}"]
  source_dest_check      = false
  user_data              = "${file("${path.module}/data/ubuntu/v16/user_data")}"
  subnet_id              = "${var.master_subnet}"
  private_ip             = "${var.master_ip}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.master_volume_size}"
  }

  tags {
    Name        = "kubeadm-master"
    Description = "Master worker for kubernetes"
    Environment = "testing"
  }
}
