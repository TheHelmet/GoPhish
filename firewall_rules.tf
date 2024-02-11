resource "aws_security_group" "phish" {
  name        = "Phisherman1"
  description = "GoPhish"
  vpc_id      = aws_vpc.vpc_phishnet.id
}

# GENERAL

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.phish.id
  description       = "all outbound"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
}


resource "aws_vpc_security_group_ingress_rule" "ssh_inbound_my_ip" {
  security_group_id = aws_security_group.phish.id
  description       = "SSH Inbound from runner and my OP"
  from_port         = 22
  cidr_blocks        = var.admin_ip
  to_port           = 22
  ip_protocol       = "tcp"
}


resource "aws_vpc_security_group_ingress_rule" "https_admin_inbound_my_ip" {
  security_group_id = aws_security_group.phish.id
  description       = "HTTPs Inbound for mgmt"
  from_port         = 3333
  cidr_blocks      = var.admin_ip
  to_port           = 3333
  ip_protocol       = "tcp"
}
