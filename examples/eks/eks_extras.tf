## Cluster autoscaler
 
 module "eks_cluster_autoscaler" {
    source = "../../modules/eks/extras/autoscaler"
    cluster_name = module.eks_cluster1.name
    cluster_ca_certificate = module.eks_cluster1.cluster_ca_cert
    cluster_endpoint = module.eks_cluster1.endpoint
    node_selector = module.ek_node_tools.name
  }


##Requires EBS CSI DRIVER

module "eks_cluster_monitoring" {
    source = "../../modules/eks/extras/kube-prometheus-loki"
    cluster_name = module.eks_cluster1.name
    cluster_endpoint = module.eks_cluster1.endpoint
    node_selector = module.ek_node_tools.name

}

module "eks_cluster_alb_controller" {
  source = "../../modules/eks/extras/aws-alb-controller"
  cluster_name = module.eks_cluster1.name
  cluster_endpoint = module.eks_cluster1.endpoint
  node_selector = module.ek_node_tools.name
  cluster_ca_certificate = module.eks_cluster1.cluster_ca_cert
  lbc_role_arn = module.eks_cluster1.alb_controller_role
}