resource "aws_ec2_transit_gateway_vpc_attachment" "main" {
  subnet_ids         = var.subnets
  transit_gateway_id = var.tgw_id
  vpc_id             = var.vpc_id

  tags = {
    Name = "attach-${var.environment}"
  }
}
