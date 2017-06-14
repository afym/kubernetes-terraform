variable "region" {}
variable "ami" {}
variable "instance_type" {}
variable "key_name" {}

variable "vpc_security_group_ids" {
  type = "list"
}

variable "subnet_id" {}
variable "user_data" {}
variable "volume_size" {}
variable "iam_instance_profile" {}
variable "tag_name" {}
variable "tag_description" {}
variable "tag_environment" {}
