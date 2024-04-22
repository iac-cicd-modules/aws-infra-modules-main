module "eks_node1" {
    source = "../../modules/eks/node_group"
    environment = var.environment
    name = "monitoring"
    cluster_name = module.eks_cluster1.name
    instance_type = "t3.medium"
    subnet_ids = module.vpc_1.private_subnets
    min_size = 1
    max_size = 10
    desired_size = 1 // DO NOT UPDATE
    tags = {
      Name = "monitoring" 
    }
    labels = {
        name = "monitoring",
    }
}

module "ek_node_tools" {
    source = "../../modules/eks/node_group"
    environment = var.environment
    name = "tools"
    cluster_name = module.eks_cluster1.name
    instance_type = "t3.medium"
    subnet_ids = module.vpc_1.private_subnets
    min_size = 1
    max_size = 1
    desired_size = 1 // DO NOT UPDATE
    labels = {
        name = "tools"
    }
    tags = {
      "k8s.io/cluster-autoscaler/enabled"	 = "false",
      Name = "tools" 
    }
}