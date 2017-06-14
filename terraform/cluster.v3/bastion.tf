resource "aws_instance" "kubernetes_bastion" {
  ami                    = "${var.kubernentes_bastion_ami}"
  instance_type          = "${var.kubernentes_bastion_instance_type}"
  key_name               = "${var.kubernentes_bastion_key_name}"
  vpc_security_group_ids = ["${aws_security_group.bastion_security_group.id}"]
  subnet_id              = "${module.kubernetes_subnet_d.id}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.kubernentes_bastion_volume_size}"
  }

  tags {
    Name        = "kubernetes-bastion"
    Environment = "test"
    Description = "Kubernetes bastion access"
  }
}
