resource "aws_eks_addon" "this" {
    for_each = { for k, v in var.eks_cluster_addons : k => v }

    cluster_name = aws_eks_cluster.cluster.name
  
    addon_name   = try(each.value.name, each.key)
    addon_version = lookup(each.value, "addon_version", null)
    resolve_conflicts_on_update = lookup(each.value, "resolve_conflicts_on_update", null)
    service_account_role_arn = lookup(each.value, "service_account_role_arn", null)
}

