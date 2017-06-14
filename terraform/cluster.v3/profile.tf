module "kubernetes_master_profile" {
  source             = "./modules/aws/identity/iam"
  region             = "${var.region}"
  profile_name       = "${var.kubernetes_master_profile_name}"
  role_name          = "${var.kubernetes_master_role_name}"
  assume_role_policy = "${file("${path.module}/data/master/role.json")}"
  policy_name        = "${var.kubernetes_master_policy_name}"
  policy             = "${file("${path.module}/data/master/policy.json")}"
}

module "kubernetes_node_profile" {
  source             = "./modules/aws/identity/iam"
  region             = "${var.region}"
  profile_name       = "${var.kubernetes_node_profile_name}"
  role_name          = "${var.kubernetes_node_role_name}"
  assume_role_policy = "${file("${path.module}/data/node/role.json")}"
  policy_name        = "${var.kubernetes_node_policy_name}"
  policy             = "${file("${path.module}/data/node/policy.json")}"
}
