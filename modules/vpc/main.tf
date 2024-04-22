resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-${var.name}-${var.environment}-${var.region}"
  }
}

resource "aws_subnet" "public-subnet-1" {
  cidr_block              = var.public_subnet_1_cidr
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-a-pub-${var.name}-${var.environment}-${var.region}"
  }
}

resource "aws_subnet" "public-subnet-2" {
  cidr_block              = var.public_subnet_2_cidr
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-b-pub-${var.name}-${var.environment}-${var.region}"
  }
}

resource "aws_subnet" "public-subnet-3" {
  cidr_block              = var.public_subnet_3_cidr
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-c-pub-${var.name}-${var.environment}-${var.region}"
  }
}

resource "aws_subnet" "private-subnet-1" {
  cidr_block              = var.private_subnet_1_cidr
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = false

  tags = {
    Name = "subnet-a-priv-${var.name}-${var.environment}-${var.region}"
  }
}

resource "aws_subnet" "private-subnet-2" {
  cidr_block              = var.private_subnet_2_cidr
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = false

  tags = {
    Name = "subnet-b-priv-${var.name}-${var.environment}-${var.region}"
  }
}

resource "aws_subnet" "private-subnet-3" {
  cidr_block              = var.private_subnet_3_cidr
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = false

  tags = {
    Name = "subnet-c-priv-${var.name}-${var.environment}-${var.region}"
  }
}

resource "aws_subnet" "database-subnet-1" {
  cidr_block              = var.db_subnet_1_cidr
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = false

  tags = {
    Name = "subnet-a-database-${var.name}-${var.environment}-${var.region}"
  }
}

resource "aws_subnet" "database-subnet-2" {
  cidr_block              = var.db_subnet_2_cidr
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = false

  tags = {
    Name = "subnet-b-database-${var.name}-${var.environment}-${var.region}"
  }
}

resource "aws_subnet" "database-subnet-3" {
  cidr_block              = var.db_subnet_3_cidr
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = false

  tags = {
    Name = "subnet-c-database-${var.name}-${var.environment}-${var.region}"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "rt-pub-${var.name}-${var.environment}-${var.region}"
  }
}

resource "aws_route_table" "private-route-table1" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "rt-priv-${var.name}-${var.environment}-${var.region}a"
  }
}

resource "aws_route_table" "private-route-table2" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "rt-priv-${var.name}-${var.environment}-${var.region}b"
  }
}

resource "aws_route_table" "private-route-table3" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "rt-priv-${var.name}-${var.environment}-${var.region}c"
  }
}

resource "aws_route_table" "database-route-table" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "rt-database-${var.name}-${var.environment}-${var.region}"
  }
}


resource "aws_route_table_association" "public-route-1-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-1.id
}

resource "aws_route_table_association" "public-route-2-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-2.id
}

resource "aws_route_table_association" "public-route-3-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-3.id
}

resource "aws_route_table_association" "private-route-1-association" {
  route_table_id = aws_route_table.private-route-table1.id
  subnet_id      = aws_subnet.private-subnet-1.id
}

resource "aws_route_table_association" "private-route-2-association" {
  route_table_id = aws_route_table.private-route-table2.id
  subnet_id      = aws_subnet.private-subnet-2.id
}

resource "aws_route_table_association" "private-route-3-association" {
  route_table_id = aws_route_table.private-route-table3.id
  subnet_id      = aws_subnet.private-subnet-3.id
}

resource "aws_route_table_association" "database-route-1-association" {
  route_table_id = aws_route_table.database-route-table.id
  subnet_id      = aws_subnet.database-subnet-1.id
}

resource "aws_route_table_association" "database-route-2-association" {
  route_table_id = aws_route_table.database-route-table.id
  subnet_id      = aws_subnet.database-subnet-2.id
}

resource "aws_route_table_association" "database-route-3-association" {
  route_table_id = aws_route_table.database-route-table.id
  subnet_id      = aws_subnet.database-subnet-3.id
}

resource "aws_eip" "elastic-ip-for-nat-gw" {
  tags = {
    Name = "ip-nat-${var.name}-${var.environment}-${var.region}"
  }
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.elastic-ip-for-nat-gw.id
  subnet_id     = aws_subnet.public-subnet-1.id  # Change this line to use a public subnet

  tags = {
    Name = "nat-${var.name}-${var.environment}-${var.region}"
  }
}

resource "aws_route" "nat-gw-route" {
  count                  = 3
  route_table_id         = element([aws_route_table.private-route-table1.id, aws_route_table.private-route-table2.id, aws_route_table.private-route-table3.id], count.index)
  nat_gateway_id         = aws_nat_gateway.nat-gw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_internet_gateway" "terraform-igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "igw-${var.name}-${var.environment}"
  }
}

resource "aws_route" "public-internet-igw-route" {
  route_table_id         = aws_route_table.public-route-table.id
  gateway_id             = aws_internet_gateway.terraform-igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.region}.s3"
}

resource "aws_vpc_endpoint_route_table_association" "main" {
  route_table_id  = aws_route_table.database-route-table.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}


output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet-1_id" {
  value = aws_subnet.public-subnet-1.id
}

output "public_subnet-2_id" {
  value = aws_subnet.public-subnet-2.id
}

output "public_subnet-3_id" {
  value = aws_subnet.public-subnet-3.id
}

output "private_subnet-1_id" {
  value = aws_subnet.private-subnet-1.id
}

output "private_subnet-2_id" {
  value = aws_subnet.private-subnet-2.id
}

output "private_subnet-3_id" {
  value = aws_subnet.private-subnet-3.id
}

output "database_subnet-1_id" {
  value = aws_subnet.database-subnet-1.id
}

output "database_subnet-2_id" {
  value = aws_subnet.database-subnet-2.id
}

output "database_subnet-3_id" {
  value = aws_subnet.database-subnet-3.id
}

output "name" {
  value = aws_vpc.main.tags["Name"]

}

output "private_subnets" {
  value = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id, aws_subnet.private-subnet-3.id]
}

output "route_tables" {
  value = [aws_route_table.private-route-table1.id,
    aws_route_table.private-route-table2.id,
    aws_route_table.private-route-table3.id,
    aws_route_table.public-route-table.id,
  aws_route_table.database-route-table.id]
}
