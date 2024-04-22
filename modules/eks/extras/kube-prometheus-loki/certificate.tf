resource "null_resource" "cluster_ca_cert" {
  provisioner "local-exec" {
    command = "aws eks describe-cluster --name ${var.cluster_name} --query cluster.certificateAuthority --output text > ${path.module}/clusterCA.txt"    
  }
  depends_on = [data.local_file.cluster_ca_cert]
}

data "local_file" "cluster_ca_cert" {
  filename = "${path.module}/clusterCA.txt"
  
}