provider "aws" {
  region = "${var.region}"
}

# creating the kubernetes vpc

module "kubernetes_vpc" {
  source = "./modules/aws/network/vpc"
  region = "${var.region}"

  # vpc
  cidr_block = "${var.kubernetes_vpc_cidr_block}"

  # tags for resource
  tag_name        = "kubernetes-vpc"
  tag_environment = "test"
  tag_description = "Kubernetes's VPC"
}

module "kubernetes_public_subnet" {
  source = "./modules/aws/network/subnet"
  region = "${var.region}"

  # subnet
  vpc_id            = "${module.kubernetes_vpc.vpc_id}"
  cidr_block        = "${var.kubernetes_public_subnet_cidr_block}"
  availability_zone = "${var.kubernetes_public_subnet_availability_zone}"

  # tags for resource
  tag_name        = "kubernetes-public-subnet"
  tag_environment = "test"
  tag_description = "Kubernetes's public subnet for master"
}

module "kubernetes_private_subnet" {
  source = "./modules/aws/network/subnet"
  region = "${var.region}"

  # subnet
  vpc_id            = "${module.kubernetes_vpc.vpc_id}"
  cidr_block        = "${var.kubernetes_private_subnet_cidr_block}"
  availability_zone = "${var.kubernetes_private_subnet_availability_zone}"

  # tags for resource
  tag_name        = "kubernetes-private-subnet"
  tag_environment = "test"
  tag_description = "Kubernetes's private subnet for master"
}

module "kubernetes_internet_gateway" {
  source = "./modules/aws/network/gateway"
  region = "${var.region}"

  # vpc
  vpc_id = "${module.kubernetes_vpc.vpc_id}"

  # tags for resource
  tag_name        = "kubernetes-gateway"
  tag_environment = "test"
  tag_description = "Kubernetes's internet gateway"
}

module "kubernetes_ip_nat" {
  source = "./modules/aws/network/ip"
  region = "${var.region}"
}

module "kubernetes_nat_gateway" {
  source = "./modules/aws/network/nat"
  region = "${var.region}"

  # vpc
  allocation_id = "${module.kubernetes_ip_nat.ip_id}"
  subnet_id     = "${module.kubernetes_public_subnet.subnet_id}"
}

module "kubernetes_security_groups" {
  source = "./modules/aws/network/security"
  region = "${var.region}"

  # security
  vpc_id = "${module.kubernetes_vpc.vpc_id}"
}

module "kubernetes_router" {
  source = "./modules/aws/network/router"
  region = "${var.region}"

  # vpc
  vpc_id         = "${module.kubernetes_vpc.vpc_id}"
  gateway_id     = "${module.kubernetes_internet_gateway.gateway_id}"
  nat_gateway_id = "${module.kubernetes_nat_gateway.nat_id}"
}

resource "aws_route_table_association" "association_nat" {
  subnet_id      = "${module.kubernetes_private_subnet.subnet_id}"
  route_table_id = "${module.kubernetes_router.nat}"
}

resource "aws_route_table_association" "association_gateway" {
  subnet_id      = "${module.kubernetes_public_subnet.subnet_id}"
  route_table_id = "${module.kubernetes_router.gateway}"
}

# creating kubernetes cluster

module "k8s_key_pair" {
  source = "./modules/aws/compute/keys"

  region     = "${var.region}"
  key_name   = "k8s_key_pair"
  public_key = "${file("${path.module}/data/k8s.public.key.data")}"
}

module "k8s_master" {
  source = "./modules/aws/compute/ec2/master"

  # required values
  region        = "${var.region}"
  ami           = "${var.kubernetes_master_ami}"
  instance_type = "t2.medium"

  # optional values
  key_name               = "${module.k8s_key_pair.key_name}"
  subnet_id              = "${module.kubernetes_public_subnet.subnet_id}"
  user_data              = "${file("${path.module}/data/master/centos/v7.3/v1.5/user_data")}"
  vpc_security_group_ids = ["${module.kubernetes_security_groups.master}"]

  # tags for resource
  tag_name        = "afym.com k8s master"
  tag_environment = "test"
  tag_description = "A basic ec2 instance for AWS"
}

module "k8s_node_01" {
  source = "./modules/aws/compute/ec2/node"

  # required values
  region        = "${var.region}"
  ami           = "${var.kubernetes_node_ami}"
  instance_type = "t2.medium"

  # optional values
  key_name               = "${module.k8s_key_pair.key_name}"
  vpc_security_group_ids = ["${module.kubernetes_security_groups.node}"]
  subnet_id              = "${module.kubernetes_private_subnet.subnet_id}"
  user_data              = "${file("${path.module}/data/node/centos/v7.3/v1.5/user_data")}"

  # tags for resource
  tag_name        = "afym.com k8s node 01"
  tag_environment = "test"
  tag_description = "A basic ec2 instance for AWS ${module.k8s_master.master_ip}"
}
