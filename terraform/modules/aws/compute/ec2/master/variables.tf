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

variable "private_key" {
  description = "..."
}

variable "provisioner_source" {
  description = "..."
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
