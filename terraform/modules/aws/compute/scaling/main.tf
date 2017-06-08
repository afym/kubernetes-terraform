provider "aws" {
  region = "${var.region}"
}

resource "aws_launch_configuration" "module_aws_scaling_node" {
  name                 = "kubernetes_${var.cluster_code}_${var.cluster_version}_node"
  image_id             = "${var.node_image_id}"
  instance_type        = "${var.node_instance_type}"
  security_groups      = ["${var.node_security_groups}"]
  key_name             = "${var.key_name}"
  iam_instance_profile = "${var.node_iam_instance_profile}"
  user_data            = "${var.node_user_data}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.node_volume_size}"
  }
}

resource "aws_autoscaling_group" "module_aws_scaling_node_group" {
  name                 = "kubernetes_${var.cluster_code}_${var.cluster_version}_node_group"
  launch_configuration = "${aws_launch_configuration.module_aws_scaling_node.id}"
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  vpc_zone_identifier  = ["${var.node_subnet}"]

  tag = {
    key                 = "Name"
    value               = "kubernetes_${var.cluster_code}_${var.cluster_version}_node_group"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Environment"
    value               = "test"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Description"
    value               = "Auto scaling group for nodes"
    propagate_at_launch = true
  }
}

# autoscaling policies

resource "aws_autoscaling_policy" "module_aws_scaling_node_policy_up" {
  name                   = "kubernetes_${var.cluster_code}_${var.cluster_version}_node_high_cpu"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.module_aws_scaling_node_group.name}"
}

resource "aws_cloudwatch_metric_alarm" "module_aws_scaling_node_metric_up" {
  alarm_name          = "kubernetes_${var.cluster_code}_${var.cluster_version}_node_alarma_high_cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "${var.node_threshold_up}"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.module_aws_scaling_node_group.name}"
  }

  alarm_actions = ["${aws_autoscaling_policy.module_aws_scaling_node_policy_up.arn}"]
}

resource "aws_autoscaling_policy" "module_aws_scaling_node_policy_down" {
  name                   = "kubernetes_${var.cluster_code}_${var.cluster_version}_node_low_cpu"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.module_aws_scaling_node_group.name}"
}

resource "aws_cloudwatch_metric_alarm" "module_aws_scaling_node_metric_low" {
  alarm_name          = "kubernetes_${var.cluster_code}_${var.cluster_version}_node_alarma_low_cpu"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "${var.node_threshold_down}"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.module_aws_scaling_node_group.name}"
  }

  alarm_actions = ["${aws_autoscaling_policy.module_aws_scaling_node_policy_down.arn}"]
}
