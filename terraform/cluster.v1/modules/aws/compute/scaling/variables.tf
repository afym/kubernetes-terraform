variable "region" {
  description = "aws region"
}

# general variables

variable "key_name" {
  description = "The name for the key pair"
}

variable "cluster_code" {
  description = "Kubernetes cluster code"
}

variable "cluster_version" {
  description = "Kubernetes cluster version"
}

# node variables
variable "node_subnet" {
  description = "subnet id for nodes"
}

variable "node_image_id" {
  description = "ami id for nodes"
}

variable "node_security_groups" {
  type        = "list"
  description = "security group ids"
}

variable "node_instance_type" {
  description = "instance type for nodes"
}

variable "node_volume_size" {
  description = "volume size for nodes"
}

variable "node_threshold_up" {
  description = "limit of cpu utilization per node instances to scale"
}

variable "node_threshold_down" {
  description = "limit of cpu utilization per node instances to down scale"
}

variable "node_iam_instance_profile" {
  description = "iam profile for node"
}

variable "node_user_data" {
  description = "user data script for node"
}
