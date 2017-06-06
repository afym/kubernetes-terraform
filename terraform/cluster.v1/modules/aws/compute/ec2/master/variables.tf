variable "region" {
  description = "aws region"
}

# general variables

variable "ami" {
  description = "The AMI to use for the instance"
}

variable "instance_type" {
  description = "The type of instance to start"
}

# optional variables

variable "key_name" {
  description = "The key name to use for the instance"
}

variable "vpc_security_group_ids" {
  type        = "list"
  description = "A list of security group ids"
}

variable "subnet_id" {
  description = "The subnet id for the instance"
}

variable "user_data" {
  description = "The path for the user data script to boot some configuration"
}

variable "volume_size" {
  description = "volume size for the root disk"
}

variable "private_ip" {
  description = "private ip for the master"
}

variable "iam_instance_profile" {
  description = "The instnace profile for the master"
}

# tags

variable "tag_name" {
  description = "The name tag"
}

variable "tag_description" {
  description = "The description tag"
}

variable "tag_environment" {
  description = "The environment tag"
}
