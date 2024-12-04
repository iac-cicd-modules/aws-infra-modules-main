resource "aws_vpc" "main" {
  for_each             = var.vpcs
  cidr_block           = var.vpcs[each.key].cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-${var.vpcs[each.key].name}-${var.environment}-${var.region}"
  }
}

resource "aws_subnet" "public-subnet" {
  for_each = merge([
    for vpc_key, vpc in var.vpcs : {
      for subnet_key, subnet in vpc.public_subnets :
      "${vpc_key}-${subnet_key}" => {
        vpc           = vpc_key
        subnet_key    = subnet_key
        subnet_config = subnet
      }
    }
  ]...)

  vpc_id                  = aws_vpc.main[each.value.vpc].id
  cidr_block              = each.value.subnet_config.cidr_block
  availability_zone       = "${var.region}${each.value.subnet_config.az}"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-${each.value.subnet_config.az}-pub-${var.vpcs[each.value.vpc].name}-${var.environment}-${var.region}"
  }
}

resource "aws_subnet" "private-subnet" {
  for_each = merge([
    for vpc_key, vpc in var.vpcs : {
      for subnet_key, subnet in vpc.private_subnets :
      "${vpc_key}-${subnet_key}" => {
        vpc           = vpc_key
        subnet_key    = subnet_key
        subnet_config = subnet
      }
    }
  ]...)
  vpc_id                  = aws_vpc.main[each.value.vpc].id
  cidr_block              = each.value.subnet_config.cidr_block
  availability_zone       = "${var.region}${each.value.subnet_config.az}"
  map_public_ip_on_launch = false

  tags = {
    Name = "subnet-${each.value.subnet_config.az}-priv-${var.vpcs[each.value.vpc].name}-${var.environment}-${var.region}"
  }
}

resource "aws_route_table" "public-route-table" {
  for_each = merge([
    for vpc_key, vpc in var.vpcs : {
      for subnet_key, subnet in vpc.public_subnets :
      "${vpc_key}-${subnet_key}" => {
        vpc_key = vpc_key
        subnet  = subnet
      }
    }
  ]...)
  vpc_id = aws_vpc.main[each.value.vpc_key].id
  tags = {
    Name = "rt-pub-${var.vpcs[each.value.vpc_key].name}-${var.environment}-${var.region}"
  }
}

resource "aws_route_table" "private-route-table" {
  for_each = merge([
    for vpc_key, vpc in var.vpcs : {
      for subnet_key, subnet in vpc.private_subnets :
      "${vpc_key}-${subnet_key}" => {
        vpc_key = vpc_key
        subnet  = subnet
      }
    }
  ]...)

  vpc_id = aws_vpc.main[each.value.vpc_key].id

  tags = {
    Name = "rt-priv-${var.vpcs[each.value.vpc_key].name}-${var.environment}-${var.region}${each.value.subnet.az}"
  }
}

resource "aws_route_table_association" "public-route-association" {
  for_each = merge([
    for vpc_key, vpc in var.vpcs : {
      for subnet_key, subnet in vpc.public_subnets :
      "${vpc_key}-${subnet_key}" => {
        vpc_key = vpc_key
        subnet  = subnet
      }
    }
  ]...)
  route_table_id = aws_route_table.public-route-table[each.key].id
  subnet_id      = aws_subnet.public-subnet[each.key].id
}

resource "aws_route_table_association" "private-route-association" {
  for_each = merge([
    for vpc_key, vpc in var.vpcs : {
      for subnet_key, subnet in vpc.private_subnets :
      "${vpc_key}-${subnet_key}" => {
        vpc_key = vpc_key
        subnet  = subnet
      }
    }
  ]...)
  route_table_id = aws_route_table.private-route-table[each.key].id
  subnet_id      = aws_subnet.private-subnet[each.key].id
}

resource "aws_eip" "elastic-ip-for-nat-gw" {
  tags = {
    Name = "ip-nat-${var.name}-${var.environment}-${var.region}"
  }
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.elastic-ip-for-nat-gw.id
  subnet_id     = element([for subnet in aws_subnet.public-subnet : subnet.id], 0)

  tags = {
    Name = "nat-${var.name}-${var.environment}-${var.region}"
  }
}

resource "aws_route" "nat-gw-route" {
  for_each = {
    for rt_key, rt in aws_route_table.private-route-table : rt_key => rt.id
  }

  route_table_id         = each.value
  nat_gateway_id         = aws_nat_gateway.nat-gw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_internet_gateway" "terraform-igw" {
  for_each = var.vpcs
  vpc_id   = aws_vpc.main[each.key].id
  tags = {
    Name = "igw-${var.vpcs[each.key].name}-${var.environment}"
  }
}

resource "aws_route" "public-internet-igw-route" {
  for_each = merge([
    for vpc_key, vpc in var.vpcs : {
      for subnet_key, subnet in vpc.public_subnets :
      "${vpc_key}-${subnet_key}" => {
        vpc_key = vpc_key
        subnet  = subnet
      }
    }
  ]...)
  route_table_id         = aws_route_table.public-route-table[each.key].id
  gateway_id             = aws_internet_gateway.terraform-igw[each.value.vpc_key].id
  destination_cidr_block = "0.0.0.0/0"
}

