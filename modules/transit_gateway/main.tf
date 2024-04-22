resource "aws_ec2_transit_gateway" "main" {
  amazon_side_asn                 = 64512
  auto_accept_shared_attachments  = "enable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  dns_support                     = "enable"
  vpn_ecmp_support                = "enable"


  tags = {
    Name = "tgw-${var.name}-${var.environment}-${var.region}"
  }
}

output "id" {
  value = aws_ec2_transit_gateway.main.id
}

output "route_table_id" {
  value = aws_ec2_transit_gateway.main.association_default_route_table_id

}


resource "aws_ram_resource_share" "main" {
  name                      = "tgw-share-${var.region}"
  allow_external_principals = false

}


resource "aws_ram_resource_association" "main" {
  resource_arn       = aws_ec2_transit_gateway.main.arn
  resource_share_arn = aws_ram_resource_share.main.arn
}


resource "aws_ram_principal_association" "main" {
  for_each           = toset(var.account_ids)
  principal          = each.key
  resource_share_arn = aws_ram_resource_share.main.arn
}

