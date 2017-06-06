# general variables
region = "ap-southeast-2"

cluster_code = "c01"

cluster_version = "v1.5.4"

# vpc variables
kubernetes_vpc_cidr_block = "10.0.0.0/16"

kubernetes_public_subnet_cidr_block = "10.0.1.0/24"

kubernetes_public_subnet_availability_zone = "ap-southeast-2a"

kubernetes_private_subnet_cidr_block = "10.0.2.0/24"

kubernetes_private_subnet_availability_zone = "ap-southeast-2b"

# iam variables
master_role_name = "kubernetes_master_role"

master_profile_name = "kubernetes_master_profile"

master_policy_name = "kubernetes_master_policy"

# iam variables
node_role_name = "kubernetes_node_role"

node_profile_name = "kubernetes_node_profile"

node_policy_name = "kubernetes_node_policy"

# variables for master
private_ip_master = "10.0.1.100" # >> if this value is change you must to change the data user_data script too

image_id_master = "ami-b6e4f3d5"

instance_type_master = "t2.medium"

volume_size_master = "10"

# auto scaling variables for nodes
node_image_id = "ami-aae5f2c9"

node_instance_type = "t2.micro"

node_volume_size = "10"

node_threshold_up = "70"

node_threshold_down = "20"
