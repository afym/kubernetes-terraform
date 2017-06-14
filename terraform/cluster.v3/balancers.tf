module "kubernetes_balancer_service_1" {
  source          = "./modules/aws/compute/balancer/http"
  region          = "${var.region}"
  name            = "${var.kubernetes_master_ami}"
  subnets         = ["${module.kubernetes_subnet_a.id}", "${module.kubernetes_subnet_b.id}", "${module.kubernetes_subnet_c.id}"]
  security_groups = ["${aws_security_group.balancer_service_1_security_group.id}"]
  instance_port   = 3001
  tag_name        = "kubernetes-balancer-1"
  tag_environment = "test"
  tag_description = "Kubernetes balancer 1"
}

resource "aws_security_group" "balancer_service_1_security_group" {
  name        = "kubernetes_balancer_service_1"
  description = "security group for microservice 1"

  vpc_id = "${module.kubernetes_vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
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
    Name        = "kubernetes-balancer-s1"
    Environment = "test"
    Description = "Kubernetes's balancer for microservice 01"
  }
}
