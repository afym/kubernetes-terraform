variable "region" {}
variable "name" {}
variable "image_id" {}
variable "instance_type" {}

variable "security_groups" {
  type = "list"
}

variable "key_name" {}
variable "iam_instance_profile" {}
variable "user_data" {}
variable "volume_size" {}
variable "min_size" {}
variable "max_size" {}
variable "desired_capacity" {}

variable "load_balancers" {
  type = "list"
}

variable "vpc_zone_identifier" {
  type = "list"
}

variable "metric_up_threshold" {}
variable "metric_down_threshold" {}
