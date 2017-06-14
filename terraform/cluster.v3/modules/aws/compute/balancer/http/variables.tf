variable "region" {}
variable "name" {}

variable "subnets" {
  type = "list"
}

variable "security_groups" {
  type = "list"
}

variable "instance_port" {}
variable "tag_name" {}
variable "tag_environment" {}
variable "tag_description" {}
