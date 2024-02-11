resource "aws_vpc" "vpc_phishnet" {
  cidr_block = "192.168.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-phishnet"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc_phishnet.id
  tags = {
    Name = "vpc-phishnet-igw"
  }
}

resource "aws_subnet" "phishnet" {
  vpc_id     = aws_vpc.vpc_phishnet.id
  cidr_block = "192.168.1.0/24" # This is a subset of the VPC's CIDR block
  tags = {
    Name = "subnet-phishnet" 
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.my_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}
