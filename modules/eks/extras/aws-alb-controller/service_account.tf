resource "kubernetes_service_account_v1" "aws_eks_lbc_sa" {
  metadata {
    name = "aws-load-balancer-controller"
    namespace = "kube-system"
    labels = {
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/name" = "aws-load-balancer-controller"
    }
    annotations = {
        "eks.amazonaws.com/role-arn" = "${var.lbc_role_arn}" //"${aws_iam_role.aws_eks_lbc_role.arn}"
    }
  }

  # depends_on = [
  #   aws_iam_role.aws_eks_lbc_role,
  #   aws_iam_policy.aws_eks_lbc_policy,
  #   aws_iam_role_policy_attachment.lbc_role_policy_attach,
  #   data.local_file.cluster_ca_cert,
  #   null_resource.cluster_ca_cert
  # ]
}

