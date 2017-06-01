variable "region" {
  description = "aws region"
}

# network variables

variable "vpc_id" {
  description = "The id of the VPC that the desired subnet belongs to"
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
