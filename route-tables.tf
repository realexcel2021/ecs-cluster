
# Public Route Table

module "ECS-public-RT"{
  source = "./module/RouteTB"
  vpc_id = module.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_vpc.id
  }

  tags = {
    Name = "ECS-cluster-public-RT"
  }
}

# Associate public subnets to the public route table

resource "aws_route_table_association" "public_RT_1" {
  route_table_id = module.ECS-public-RT.id
  subnet_id      = module.public_subnet_1.id
}

resource "aws_route_table_association" "public_RT_2" {
  route_table_id = module.ECS-public-RT.id
  subnet_id      = module.public_subnet_2.id
}


# NAT gateway for private subnets

resource "aws_nat_gateway" "private_RT_NAT-gw" {
  subnet_id     = module.public_subnet_1.id
  allocation_id = aws_eip.NAT_eip.id

  tags = {
    Name = "ECS-cluster-private-NAT-gw"
  }

  depends_on = [aws_internet_gateway.two_tier_ig, aws_eip.NAT_eip]
}

resource "aws_eip" "NAT_eip" {
  domain = "vpc"
}

# Private route table

resource "aws_route_table" "ECS-private-RT" {
  vpc_id = module.main_vpc

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.private_RT_NAT-gw.id
  }

  tags = {
    Name = "ECS-cluster-private-RT"
  }
}

# Associate private subnets to the private route table

resource "aws_route_table_association" "private_RT_1" {
  route_table_id = aws_route_table.ECS-private-RT.id
  subnet_id      = module.private_subnet_1.id
}

resource "aws_route_table_association" "private_RT_2" {
  route_table_id = aws_route_table.ECS-private-RT.id
  subnet_id      = module.private_subnet_2.id
}