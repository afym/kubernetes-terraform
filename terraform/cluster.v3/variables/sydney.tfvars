region = "ap-southeast-2"

kubernetes_vpc_cidr_block = "10.0.0.0/16"

kubernetes_subnet_a_cidr_block = "10.0.1.0/24"

kubernetes_subnet_a_availability_zone = "ap-southeast-2a"

kubernetes_subnet_a_public_ip = false

kubernetes_subnet_b_cidr_block = "10.0.2.0/24"

kubernetes_subnet_b_availability_zone = "ap-southeast-2b"

kubernetes_subnet_b_public_ip = false

kubernetes_subnet_c_cidr_block = "10.0.3.0/24"

kubernetes_subnet_c_availability_zone = "ap-southeast-2c"

kubernetes_subnet_c_public_ip = false

kubernetes_subnet_d_cidr_block = "10.0.4.0/24"

kubernetes_subnet_d_availability_zone = "ap-southeast-2a"

kubernetes_subnet_d_public_ip = true

kubernetes_master_profile_name = "kubernetes_master_profile"

kubernetes_master_role_name = "kubernetes_master_role"

kubernetes_master_policy_name = "kubernetes_master_policy"

kubernetes_node_profile_name = "kubernetes_node_profile"

kubernetes_node_role_name = "kubernetes_node_role"

kubernetes_node_policy_name = "kubernetes_node_policy"

kubernentes_bastion_ami = "ami-162c2575"

kubernentes_bastion_instance_type = "t2.nano"

kubernentes_bastion_key_name = "mycustom_sydney"

kubernentes_bastion_volume_size = "8"

kubernetes_master_ami = "ami-96666ff5"

kubernetes_master_instance_type = "t2.micro"

kubernetes_master_key_name = "mycustom_sydney"

kubernetes_master_volume_size = "20"

kubernentes_node_ami = "ami-96666ff5"

kubernetes_node_instance_type = "t2.micro"

kubernetes_node_key_name = "mycustom_sydney"

kubernetes_node_volume_size = "25"

kubernetes_node_min = 1

kubernetes_node_max = 3

kubernetes_node_desired = 3

kubernetes_node_up = 70

kubernetes_node_down = 40
