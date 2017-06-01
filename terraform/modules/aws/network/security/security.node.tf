resource "aws_security_group" "module_aws_network_security_node" {
  name        = "sg_nodes"
  description = "security group for nodes"

  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "kubernetes-node"
    Environment = "test"
    Description = "Kubernetes's nodes security group"
  }
}
