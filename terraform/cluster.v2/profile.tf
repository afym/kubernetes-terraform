module "kubernetes_private_key" {
  source = "./../modules/aws/compute/keys"

  region     = "${var.region}"
  key_name   = "k8s_key_pair"
  public_key = "${file("${path.module}/data/k8s.public.key.data")}"
}

resource "aws_security_group" "master_aws_security_group" {
  name        = "sg_kubeadm_master"
  description = "Security group for master worker"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "sg_kubeadm_master"
    Environment = "testing"
    Description = "Kubernetes's master security group (just for testing porpuse)"
  }
}

resource "aws_security_group" "node_aws_security_group" {
  name        = "sg_kubeadm_node"
  description = "Security group for node worker"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "sg_kubeadm_master"
    Environment = "testing"
    Description = "Kubernetes's nodes security group (just for testing porpuse)"
  }
}
