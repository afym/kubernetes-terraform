provider "aws" {
  region = "${var.region}"
}

resource "aws_iam_instance_profile" "module_aws_profile" {
  name = "${var.profile_name}"
  role = "${aws_iam_role.module_aws_role.id}"
}

resource "aws_iam_role" "module_aws_role" {
  name               = "${var.role_name}"
  assume_role_policy = "${var.assume_role_policy}"
}

resource "aws_iam_role_policy" "module_aws_policy" {
  name   = "${var.policy_name}"
  role   = "${aws_iam_role.module_aws_role.name}"
  policy = "${var.policy}"
}
