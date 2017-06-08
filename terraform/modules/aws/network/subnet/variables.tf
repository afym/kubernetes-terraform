variable "region" {
  description = "aws region"
}

# network variables

variable "vpc_id" {
  description = "The id of the VPC that the desired subnet belongs to"
}

variable "cidr_block" {
  description = "The cidr block of the desired subnet"
}

variable "availability_zone" {
  description = "The availability zone where the subnet must reside"
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
