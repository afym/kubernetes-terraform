resource "aws_security_group" "bastion_security_group" {
  name        = "kubernetes_bastion"
  description = "security group for bastion"

  vpc_id = "${module.kubernetes_vpc.id}"

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
    Name        = "kubernetes-bastion"
    Environment = "test"
    Description = "Kubernetes's bastion security group"
  }
}

resource "aws_security_group" "kubernetes_master_security_group" {
  name        = "kubernetes_master"
  description = "security group for master"

  vpc_id = "${module.kubernetes_vpc.id}"

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
    Name        = "kubernetes-master"
    Environment = "test"
    Description = "Kubernetes's master security group"
  }
}

resource "aws_security_group" "kubernetes_node_security_group" {
  name        = "kubernetes_node"
  description = "security group for node"

  vpc_id = "${module.kubernetes_vpc.id}"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion_security_group.id}"]
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
