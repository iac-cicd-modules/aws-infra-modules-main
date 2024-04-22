resource "aws_eks_cluster" "cluster" {
  name     = "${var.name}-${var.environment}"
  version  = var.k8s_version
  role_arn = aws_iam_role.main.arn
  enabled_cluster_log_types = var.log_options

  vpc_config {

    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    security_group_ids = [aws_security_group.main.id]

    public_access_cidrs = var.public_access_cidrs

    subnet_ids  = var.subnet_ids
    

}
 depends_on = [aws_iam_role_policy_attachment.amazon-eks-cluster-policy,
                aws_cloudwatch_log_group.eks_cluster]

}


### CERT

resource "null_resource" "cluster_ca_cert" {
  provisioner "local-exec" {
    command = "aws eks describe-cluster --name ${var.name}-${var.environment} --query cluster.certificateAuthority --output text > ${path.module}/clusterCA.txt"    
  }
  
  depends_on = [aws_eks_cluster.cluster]
}

 data "local_file" "cluster_ca_cert" {
   filename = "${path.module}/clusterCA.txt"
   depends_on = [null_resource.cluster_ca_cert,aws_eks_cluster.cluster]
 }

# data "external" "cluster_ca_cert" {
#   program = ["aws", "eks", "describe-cluster", "--name","${var.name}-${var.environment}", "--query","cluster.certificateAuthority", "--output", "json"]

#   depends_on = [aws_eks_cluster.cluster]

# }


output "example_output" {
  value = data.local_file.cluster_ca_cert.content
}


