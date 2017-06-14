module "kubernetes_master_instance_a" {
  source                 = "./modules/aws/compute/ec2"
  region                 = "${var.region}"
  ami                    = "${var.kubernetes_master_ami}"
  instance_type          = "${var.kubernetes_master_instance_type}"
  key_name               = "${var.kubernetes_master_key_name}"
  subnet_id              = "${module.kubernetes_subnet_a.id}"
  user_data              = "${file("${path.module}/data/master/user_data")}"
  vpc_security_group_ids = ["${aws_security_group.kubernetes_master_security_group.id}"]
  iam_instance_profile   = "${module.kubernetes_master_profile.id}"
  volume_size            = "${var.kubernetes_master_volume_size}"
  tag_name               = "kuberntes-master-a"
  tag_environment        = "test"
  tag_description        = "Kubernetes master a"
}

module "kubernetes_master_instance_b" {
  source                 = "./modules/aws/compute/ec2"
  region                 = "${var.region}"
  ami                    = "${var.kubernetes_master_ami}"
  instance_type          = "${var.kubernetes_master_instance_type}"
  key_name               = "${var.kubernetes_master_key_name}"
  subnet_id              = "${module.kubernetes_subnet_b.id}"
  user_data              = "${file("${path.module}/data/master/user_data")}"
  vpc_security_group_ids = ["${aws_security_group.kubernetes_master_security_group.id}", "${aws_security_group.kubernetes_node_security_group.id}"]
  iam_instance_profile   = "${module.kubernetes_master_profile.id}"
  volume_size            = "${var.kubernetes_master_volume_size}"
  tag_name               = "kuberntes-master-b"
  tag_environment        = "test"
  tag_description        = "Kubernetes master b"
}

module "kubernetes_master_instance_c" {
  source                 = "./modules/aws/compute/ec2"
  region                 = "${var.region}"
  ami                    = "${var.kubernetes_master_ami}"
  instance_type          = "${var.kubernetes_master_instance_type}"
  key_name               = "${var.kubernetes_master_key_name}"
  subnet_id              = "${module.kubernetes_subnet_c.id}"
  user_data              = "${file("${path.module}/data/master/user_data")}"
  vpc_security_group_ids = ["${aws_security_group.kubernetes_master_security_group.id}"]
  iam_instance_profile   = "${module.kubernetes_master_profile.id}"
  volume_size            = "${var.kubernetes_master_volume_size}"
  tag_name               = "kuberntes-master-c"
  tag_environment        = "test"
  tag_description        = "Kubernetes master c"
}
