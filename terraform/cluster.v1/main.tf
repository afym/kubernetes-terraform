provider "aws" {
  region = "${var.region}"
}

module "kubernetes_master_instance" {
  source = "./../modules/aws/compute/ec2/master"

  # required values
  region        = "${var.region}"
  ami           = "${var.image_id_master}"
  instance_type = "${var.instance_type_master}"

  # optional values
  key_name               = "${module.kubernetes_private_key.key_name}"
  subnet_id              = "${module.kubernetes_public_subnet.subnet_id}"
  user_data              = "${file("${path.module}/data/master/centos/v7.3/v1.5/user_data")}"
  vpc_security_group_ids = ["${module.kubernetes_security_groups.master}"]
  iam_instance_profile   = "${module.kubernetes_master_profile.profile_id}"
  volume_size            = "${var.volume_size_master}"
  private_ip             = "${var.private_ip_master}"

  # tags for resource
  tag_name        = "kuberntes master ${var.cluster_version} - ${var.cluster_code}"
  tag_environment = "test"
  tag_description = "A basic ec2 instance for AWS"
}

module "kubernetes_scaling_groups" {
  source = "./../modules/aws/compute/scaling/"

  region          = "${var.region}"
  key_name        = "${module.kubernetes_private_key.key_name}"
  cluster_code    = "${var.cluster_code}_${module.kubernetes_master_instance.master_ip}"
  cluster_version = "${var.cluster_version}"

  # node variables
  node_security_groups      = ["${module.kubernetes_security_groups.node}"]
  node_image_id             = "${var.node_image_id}"
  node_instance_type        = "${var.node_instance_type}"
  node_volume_size          = "${var.node_volume_size}"
  node_threshold_up         = "${var.node_threshold_up}"
  node_threshold_down       = "${var.node_threshold_down}"
  node_subnet               = "${module.kubernetes_private_subnet.subnet_id}"
  node_iam_instance_profile = "${module.kubernetes_node_profile.profile_id}"
  node_user_data            = "${file("${path.module}/data/node/centos/v7.3/v1.5/user_data")}"
}
