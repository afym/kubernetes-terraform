provider "aws" {
  region = "${var.region}"
}

resource "aws_elb" "module_aws_balancer_http" {
  name = "${var.name}-elb"

  subnets         = ["${var.subnets}"]
  security_groups = ["${var.security_groups}"]

  listener {
    instance_port     = "${var.instance_port}"
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 10
    unhealthy_threshold = 3
    timeout             = 15
    target              = "HTTP:${var.instance_port}/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name        = "${var.tag_name}"
    Environment = "${var.tag_environment}"
    Description = "${var.tag_description}"
  }
}
