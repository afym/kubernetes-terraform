module "kubernetes_vpc" {
  source          = "./modules/aws/network/vpc"
  region          = "${var.region}"
  cidr_block      = "${var.kubernetes_vpc_cidr_block}"
  tag_name        = "kubernetes-vpc"
  tag_environment = "test"
  tag_description = "Kubernetes's VPC"
}

module "kubernetes_subnet_a" {
  source                  = "./modules/aws/network/subnet"
  region                  = "${var.region}"
  vpc_id                  = "${module.kubernetes_vpc.id}"
  cidr_block              = "${var.kubernetes_subnet_a_cidr_block}"
  availability_zone       = "${var.kubernetes_subnet_a_availability_zone}"
  map_public_ip_on_launch = "${var.kubernetes_subnet_a_public_ip}"
  tag_name                = "kubernetes-subnet-a"
  tag_environment         = "test"
  tag_description         = "Kubernetes's subnet a"
}

module "kubernetes_subnet_b" {
  source                  = "./modules/aws/network/subnet"
  region                  = "${var.region}"
  vpc_id                  = "${module.kubernetes_vpc.id}"
  cidr_block              = "${var.kubernetes_subnet_b_cidr_block}"
  availability_zone       = "${var.kubernetes_subnet_b_availability_zone}"
  map_public_ip_on_launch = "${var.kubernetes_subnet_b_public_ip}"
  tag_name                = "kubernetes-subnet-b"
  tag_environment         = "test"
  tag_description         = "Kubernetes's subnet b"
}

module "kubernetes_subnet_c" {
  source                  = "./modules/aws/network/subnet"
  region                  = "${var.region}"
  vpc_id                  = "${module.kubernetes_vpc.id}"
  cidr_block              = "${var.kubernetes_subnet_c_cidr_block}"
  availability_zone       = "${var.kubernetes_subnet_c_availability_zone}"
  map_public_ip_on_launch = "${var.kubernetes_subnet_c_public_ip}"
  tag_name                = "kubernetes-subnet-c"
  tag_environment         = "test"
  tag_description         = "Kubernetes's subnet c"
}

module "kubernetes_subnet_d" {
  source                  = "./modules/aws/network/subnet"
  region                  = "${var.region}"
  vpc_id                  = "${module.kubernetes_vpc.id}"
  cidr_block              = "${var.kubernetes_subnet_d_cidr_block}"
  availability_zone       = "${var.kubernetes_subnet_d_availability_zone}"
  map_public_ip_on_launch = "${var.kubernetes_subnet_d_public_ip}"
  tag_name                = "kubernetes-subnet-d"
  tag_environment         = "test"
  tag_description         = "Kubernetes's subnet d"
}

module "kubernetes_nat_gateway_ip" {
  source = "./modules/aws/network/ip"
  region = "${var.region}"
}

module "kubernetes_nat_gateway" {
  source        = "./modules/aws/network/nat"
  region        = "${var.region}"
  allocation_id = "${module.kubernetes_nat_gateway_ip.id}"
  subnet_id     = "${module.kubernetes_subnet_d.id}"
}

module "kubernetes_gateway" {
  source          = "./modules/aws/network/gateway"
  region          = "${var.region}"
  vpc_id          = "${module.kubernetes_vpc.id}"
  tag_name        = "kubernetes-gateway"
  tag_environment = "test"
  tag_description = "Kubernetes's internet gateway"
}

module "kubernetes_router_a" {
  source          = "./modules/aws/network/router/nat"
  region          = "${var.region}"
  vpc_id          = "${module.kubernetes_vpc.id}"
  nat_gateway_id  = "${module.kubernetes_nat_gateway.id}"
  tag_name        = "kubernetes-router-a"
  tag_environment = "test"
  tag_description = "Kubernetes's router a"
}

module "kubernetes_router_b" {
  source          = "./modules/aws/network/router/nat"
  region          = "${var.region}"
  vpc_id          = "${module.kubernetes_vpc.id}"
  nat_gateway_id  = "${module.kubernetes_nat_gateway.id}"
  tag_name        = "kubernetes-router-b"
  tag_environment = "test"
  tag_description = "Kubernetes's router b"
}

module "kubernetes_router_c" {
  source          = "./modules/aws/network/router/nat"
  region          = "${var.region}"
  vpc_id          = "${module.kubernetes_vpc.id}"
  nat_gateway_id  = "${module.kubernetes_nat_gateway.id}"
  tag_name        = "kubernetes-router-c"
  tag_environment = "test"
  tag_description = "Kubernetes's router c"
}

module "kubernetes_router_d" {
  source          = "./modules/aws/network/router/gateway"
  region          = "${var.region}"
  vpc_id          = "${module.kubernetes_vpc.id}"
  gateway_id      = "${module.kubernetes_gateway.id}"
  tag_name        = "kubernetes-router-d"
  tag_environment = "test"
  tag_description = "Kubernetes's router d"
}
