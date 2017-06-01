variable "region" {
  description = "aws region"
}

# network variables
variable "vpc_id" {
  description = "The id of the VPC that the desired subnet belongs to"
}

variable "gateway_id" {
  description = "The Internet Gateway ID"
}

variable "nat_gateway_id" {
  description = "The Internet NAT Gateway ID"
}
