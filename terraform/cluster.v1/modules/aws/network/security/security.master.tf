resource "aws_security_group" "module_aws_network_security_master" {
  name        = "sg_master"
  description = "security group for master"

  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8585
    to_port     = 8585
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["${aws_security_group.module_aws_network_security_node.id}"]
  }

  ingress {
    from_port       = 6443
    to_port         = 6443
    protocol        = "tcp"
    security_groups = ["${aws_security_group.module_aws_network_security_node.id}"]
  }

  ingress {
    from_port       = 2379
    to_port         = 2379
    protocol        = "tcp"
    security_groups = ["${aws_security_group.module_aws_network_security_node.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "kubernetes-master"
    Environment = "test"
    Description = "Kubernetes's master security group"
  }
}
