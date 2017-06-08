resource "aws_instance" "node_01_aws_ec2" {
  ami                    = "${var.node_ami}"
  instance_type          = "${var.node_instance_type}"
  key_name               = "${module.kubernetes_private_key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.node_aws_security_group.id}"]
  source_dest_check      = false
  user_data              = "${file("${path.module}/data/ubuntu/v16/user_data")}"
  subnet_id              = "${var.node_subnet}"
  private_ip             = "${var.node_01_ip}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.node_volume_size}"
  }

  tags {
    Name        = "kubeadm-node-01"
    Description = "Node worker 01 for kubernetes"
    Environment = "testing"
  }
}

resource "aws_instance" "node_02_aws_ec2" {
  ami                    = "${var.node_ami}"
  instance_type          = "${var.node_instance_type}"
  key_name               = "${module.kubernetes_private_key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.node_aws_security_group.id}"]
  source_dest_check      = false
  user_data              = "${file("${path.module}/data/ubuntu/v16/user_data")}"
  subnet_id              = "${var.node_subnet}"
  private_ip             = "${var.node_02_ip}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.node_volume_size}"
  }

  tags {
    Name        = "kubeadm-node-02"
    Description = "Node worker 02 for kubernetes"
    Environment = "testing"
  }
}

resource "aws_instance" "node_03_aws_ec2" {
  ami                    = "${var.node_ami}"
  instance_type          = "${var.node_instance_type}"
  key_name               = "${module.kubernetes_private_key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.node_aws_security_group.id}"]
  source_dest_check      = false
  user_data              = "${file("${path.module}/data/ubuntu/v16/user_data")}"
  subnet_id              = "${var.node_subnet}"
  private_ip             = "${var.node_03_ip}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.node_volume_size}"
  }

  tags {
    Name        = "kubeadm-node-03"
    Description = "Node worker 03 for kubernetes"
    Environment = "testing"
  }
}
