module "kubernetes_private_key" {
  source = "./modules/aws/compute/keys"

  region     = "${var.region}"
  key_name   = "k8s_key_pair"
  public_key = "${file("${path.module}/data/k8s.public.key.data")}"
}

module "kubernetes_node_profile" {
  source = "./modules/aws/identity/iam"

  region = "${var.region}"

  profile_name       = "${var.node_profile_name}"
  role_name          = "${var.node_role_name}"
  assume_role_policy = "${file("${path.module}/data/policies/node/role.policy.json")}"
  policy_name        = "${var.node_policy_name}"
  policy             = "${file("${path.module}/data/policies/node/policy.json")}"
}

module "kubernetes_master_profile" {
  source = "./modules/aws/identity/iam"

  region = "${var.region}"

  profile_name       = "${var.master_profile_name}"
  role_name          = "${var.master_role_name}"
  assume_role_policy = "${file("${path.module}/data/policies/master/role.policy.json")}"
  policy_name        = "${var.master_policy_name}"
  policy             = "${file("${path.module}/data/policies/master/policy.json")}"
}
