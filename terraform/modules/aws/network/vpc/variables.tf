variable "region" {
  description = "aws region"
}

# network variables

variable "cidr_block" {
  description = "The cidr block of the desired subnet"
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
