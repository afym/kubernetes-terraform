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
  source = "./modules/aws/compute/ec2"

  # required values
  region        = "ap-southeast-2"
  ami           = "ami-1e02387d"
  instance_type = "t2.medium"

  # optional values
  key_name               = "${module.k8s_key_pair.key_name}"
  vpc_security_group_ids = ["${module.k8s_security_groups.master}"]

  # tags for resource
  tag_name        = "afym.com k8s master node"
  tag_environment = "test"
  tag_description = "A basic ec2 instance for AWS"
}

module "k8s_node_01" {
  source = "./modules/aws/compute/ec2"

  # required values
  region        = "ap-southeast-2"
  ami           = "ami-1e02387d"
  instance_type = "t2.micro"

  # optional values
  key_name               = "${module.k8s_key_pair.key_name}"
  vpc_security_group_ids = ["${module.k8s_security_groups.node}"]

  # tags for resource
  tag_name        = "afym.com k8s node 01"
  tag_environment = "test"
  tag_description = "A basic ec2 instance for AWS"
}
