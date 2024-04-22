output "name" {
    value = aws_eks_cluster.cluster.name 
}

output "cluster_ca_cert" {
  value = data.local_file.cluster_ca_cert.content
  depends_on = [null_resource.cluster_ca_cert]
}

output "endpoint" {
    value = aws_eks_cluster.cluster.endpoint
  
}

output "alb_controller_role" {
  value = aws_iam_role.aws_eks_lbc_role.arn
  
}