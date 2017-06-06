variable "region" {}
variable "cluster_code" {}
variable "cluster_version" {}
variable "kubernetes_vpc_cidr_block" {}
variable "kubernetes_public_subnet_cidr_block" {}
variable "kubernetes_public_subnet_availability_zone" {}
variable "kubernetes_private_subnet_cidr_block" {}
variable "kubernetes_private_subnet_availability_zone" {}
variable "master_role_name" {}
variable "master_profile_name" {}
variable "master_policy_name" {}
variable "node_role_name" {}
variable "node_profile_name" {}
variable "node_policy_name" {}

variable "private_ip_master" {}
variable "image_id_master" {}
variable "instance_type_master" {}
variable "volume_size_master" {}

variable "node_image_id" {}
variable "node_instance_type" {}
variable "node_volume_size" {}
variable "node_threshold_up" {}
variable "node_threshold_down" {}
