provider "aws" {
    region = var.region
}

# The VPC

module "main_vpc" {
  source  = "./module/VPC"
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "ECS-VPC"
  }
}

# IGW for VPC

resource "aws_internet_gateway" "igw_vpc" {
  vpc_id = module.main_vpc.id

  tags = {
    Name = "ECS-cluster-IGW"
  }
}

# The private subnets

module "private_subnet_1" {
  source                  = "./module/Subnet"
  vpc_id                  = module.main_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  Name                    = "ECS-private-subnet-1"
}

module "private_subnet_2" {
  source                  = "./module/Subnet"
  vpc_id                  = module.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"
  Name                    = "ECS-private-subnet-2"
}

# The public Subnets 

module "public_subnet_1" {
  source                  = "./module/Subnet"
  vpc_id                  = module.main_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1c"
  Name                    = "ECS-public-subnet-1"
  map_public_ip_on_launch = true
}

module "public_subnet_2" {
  source                  = "./module/Subnet"
  vpc_id                  = module.main_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"
  Name                    = "ECS-public-subnet-2"
  map_public_ip_on_launch = true
}
