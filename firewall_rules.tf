resource "aws_security_group" "phish" {
  name        = "Phisherman1"
  description = "GoPhish"
  vpc_id      = aws_vpc.vpc_phishnet.id
}

# GENERAL

resource "aws_vpc_security_group_egress_rule" "outbound_all" {
  security_group_id = aws_security_group.phish.id
  description       = "all outbound"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
}


resource "aws_vpc_security_group_ingress_rule" "ssh_inbound_my_ip" {
  security_group_id = aws_security_group.phish.id
  description       = "SSH Inbound from my IP"
  from_port         = 22
  cidr_ipv4         = "${coalesce(var.my_ip, "192.168.0.1")}/32"
  to_port           = 22
  ip_protocol       = "tcp"
}


resource "aws_vpc_security_group_ingress_rule" "mgmt" {
  security_group_id = aws_security_group.phish.id
  description       = "Mgmt Inbound from my IP"
  from_port         = 3333
  cidr_ipv4         = "${coalesce(var.my_ip, "192.168.0.1")}/32"
  to_port           = 3333
  ip_protocol       = "tcp"
}
