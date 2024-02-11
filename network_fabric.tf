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

esource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.my_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}

resource "aws_security_group" "phish" {
  name        = "Phisherman1"
  description = "GoPhish"
  vpc_id      = aws_vpc.vpc_phishnet.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.admin_ip
}
  ingress {
    from_port   = 3333
    to_port     = 3333
    protocol    = "tcp"
    cidr_blocks = var.admin_ip
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Phishnet"
  }
}
