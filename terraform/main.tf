provider "aws" {
  region = "ap-southeast-2"
}

module "k8s_security_groups" {
  source = "./modules/aws/network/security"

  region = "ap-southeast-2"
}

module "k8s_key_pair" {
  source = "./modules/aws/compute/keys"

  region     = "ap-southeast-2"
  key_name   = "k8s_key_pair"
  public_key = "${file("${path.module}/data/k8s.public.key.data")}"
}

module "k8s_master" {
  source = "./modules/aws/compute/ec2/master"

  # required values
  region        = "ap-southeast-2"
  ami           = "ami-1e02387d"
  instance_type = "t2.medium"

  # optional values
  key_name               = "${module.k8s_key_pair.key_name}"
  vpc_security_group_ids = ["${module.k8s_security_groups.master}"]

  # provisioner
  provisioner_source = "data/master/centos/v7.3/v1.5/provisioner.sh"
  private_key        = "${file("${path.module}/data/k8s.private.key.data")}"

  # tags for resource
  tag_name        = "afym.com k8s master"
  tag_environment = "test"
  tag_description = "A basic ec2 instance for AWS"
}

module "k8s_node_01" {
  source = "./modules/aws/compute/ec2/node"

  # required values
  region        = "ap-southeast-2"
  ami           = "ami-1e02387d"
  instance_type = "t2.medium"

  # optional values
  key_name               = "${module.k8s_key_pair.key_name}"
  vpc_security_group_ids = ["${module.k8s_security_groups.node}"]
  master_ip              = "${module.k8s_master.master_ip}"
  master_ip_source       = "data/node/centos/v7.3/v1.5/master.ip.config.dist"

  # provisioner
  provisioner_source = "data/node/centos/v7.3/v1.5/provisioner.sh"
  private_key        = "${file("${path.module}/data/k8s.private.key.data")}"

  # tags for resource
  tag_name        = "afym.com k8s node 01"
  tag_environment = "test"
  tag_description = "A basic ec2 instance for AWS"
}
