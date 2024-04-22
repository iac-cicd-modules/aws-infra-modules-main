
module "eks_cluster1" {
  source                = "../../modules/eks/cluster"
  name                  = "nami"
  region                = var.region
  environment           = var.environment
  k8s_version           = "1.27"
  vpc_id                = module.vpc_1.vpc_id
  subnet_ids            = module.vpc_1.private_subnets

  eks_cluster_addons = {
    kube-proxy = {
      resolve_conflicts_on_update = "OVERWRITE"
    }
   aws-ebs-csi-driver = {
     resolve_conflicts_on_update        = "OVERWRITE"
  //   service_account_role_arn = module.cluster_postinstall_eks1_nodegrp1.iam_ebs_csi_role_id
     }
  vpc-cni = {
    resolve_conflicts_on_update = "OVERWRITE"
    }
  }

}

 