module "kubernetes_nodes" {
  source                = "./modules/aws/compute/scaling/cpu"
  region                = "${var.region}"
  name                  = "kubernetes"
  load_balancers        = ["${module.kubernetes_balancer_service_1.id}"]
  image_id              = "${var.kubernentes_node_ami}"
  instance_type         = "${var.kubernetes_node_instance_type}"
  security_groups       = ["${aws_security_group.kubernetes_node_security_group.id}"]
  key_name              = "${var.kubernetes_node_key_name}"
  iam_instance_profile  = "${module.kubernetes_node_profile.id}"
  user_data             = "${file("${path.module}/data/node/user_data")}"
  volume_size           = "${var.kubernetes_node_volume_size}"
  min_size              = "${var.kubernetes_node_min}"
  max_size              = "${var.kubernetes_node_max}"
  desired_capacity      = "${var.kubernetes_node_desired}"
  vpc_zone_identifier   = ["${module.kubernetes_subnet_a.id}", "${module.kubernetes_subnet_b.id}", "${module.kubernetes_subnet_c.id}"]
  metric_up_threshold   = "${var.kubernetes_node_up}"
  metric_down_threshold = "${var.kubernetes_node_down}"
}
