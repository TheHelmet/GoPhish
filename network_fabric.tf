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
  depends_on = [
    aws_internet_gateway.gateway
  ]
  vpc_id     = aws_vpc.vpc_phishnet.id
  cidr_block = "192.168.1.0/24" # This is a subset of the VPC's CIDR block
  tags = {
    Name = "subnet-phishnet" 
  }
}

resource "aws_default_route_table" "route" {
  default_route_table_id = aws_vpc.vpc_phishnet.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }
}
