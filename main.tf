esource "aws_vpc" "vpc_phishnet" {
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

resource "aws_security_group" "phish" {
  name        = "Phisherman1"
  description = "GoPhish"
  vpc_id      = aws_vpc.vpc_phishnet.id
  ingress {
    from_port   = 0
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

resource "aws_instance" "Phisherman1" {
  ami           = ami-03cbc6cddb06af2c2
  instance_type = t2.micro
  key_name      = var.ec2_ssh_key_name
  subnet_id     = aws_subnet.phishnet.id
  tags = {
    Name = "GoPhish1"

  }
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }
  user_data                   = templatefile("cloud-init.yaml")
  vpc_security_group_ids      = [aws_security_group.tpot.id]
  associate_public_ip_address = true
}
