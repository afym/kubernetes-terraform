provider "aws" {
  region = "${var.region}"
}

resource "aws_launch_configuration" "module_aws_scaling_cpu" {
  name                 = "${var.name}-configuration"
  image_id             = "${var.image_id}"
  instance_type        = "${var.instance_type}"
  security_groups      = ["${var.security_groups}"]
  key_name             = "${var.key_name}"
  iam_instance_profile = "${var.iam_instance_profile}"
  user_data            = "${var.user_data}"

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.volume_size}"
  }
}

resource "aws_autoscaling_group" "module_aws_scaling_group_cpu" {
  name                 = "${var.name}-group"
  launch_configuration = "${aws_launch_configuration.module_aws_scaling_cpu.id}"
  load_balancers       = ["${var.load_balancers}"]
  min_size             = "${var.min_size}"
  max_size             = "${var.max_size}"
  desired_capacity     = "${var.desired_capacity}"
  vpc_zone_identifier  = ["${var.vpc_zone_identifier}"]
}

resource "aws_autoscaling_policy" "module_aws_scaling_cpu_up" {
  name                   = "${var.name}-policy-cpu-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.module_aws_scaling_group_cpu.name}"
}

resource "aws_autoscaling_policy" "module_aws_scaling_cpu_down" {
  name                   = "${var.name}-policy-cpu-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.module_aws_scaling_group_cpu.name}"
}

resource "aws_cloudwatch_metric_alarm" "module_aws_scaling_metric_up" {
  alarm_name          = "${var.name}-metric-up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "${var.metric_up_threshold}"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.module_aws_scaling_group_cpu.name}"
  }

  alarm_actions = ["${aws_autoscaling_policy.module_aws_scaling_cpu_up.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "module_aws_scaling_metric_down" {
  alarm_name          = "${var.name}-metric-down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "${var.metric_down_threshold}"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.module_aws_scaling_group_cpu.name}"
  }

  alarm_actions = ["${aws_autoscaling_policy.module_aws_scaling_cpu_down.arn}"]
}
