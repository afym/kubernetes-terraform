# general variables
region = "ap-southeast-2"

# ec2 variables

kubernetes_master_ami = "ami-b6e4f3d5"

kubernetes_node_ami = "ami-aae5f2c9"

# vpc variables

kubernetes_vpc_cidr_block = "10.0.0.0/16"

kubernetes_public_subnet_cidr_block = "10.0.1.0/24"

kubernetes_public_subnet_availability_zone = "ap-southeast-2a"

kubernetes_private_subnet_cidr_block = "10.0.2.0/24"

kubernetes_private_subnet_availability_zone = "ap-southeast-2b"
