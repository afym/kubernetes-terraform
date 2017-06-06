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
