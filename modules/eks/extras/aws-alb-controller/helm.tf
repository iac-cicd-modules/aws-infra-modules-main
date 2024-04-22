resource "helm_release" "aws_lbc_addon" {
    name  = "aws-load-balancer-controller"
    repository = "https://aws.github.io/eks-charts"
    chart = "aws-load-balancer-controller"
    namespace = "kube-system"

    set {
        name = "clusterName"
        value = "${var.cluster_name}"
    }

    set {
        name = "serviceAccount.create"
        value = "false"
    }

    set {
        name = "serviceAccount.name"
        value = "aws-load-balancer-controller"
    }

    set {
        
        name = "nodeSelector.name"
        value = var.node_selector
    }

    depends_on = [
        kubernetes_service_account_v1.aws_eks_lbc_sa,
      //  data.local_file.cluster_ca_cert,
    ]
}


