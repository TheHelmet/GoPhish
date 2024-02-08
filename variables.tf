variable "admin_ip" {
  default     = ["127.0.0.1/32", "159.196.130.62/32"]
  description = "admin IP addresses in CIDR format"
}

##variable "ec2_vpc_id" {
 ## description = "ID of AWS VPC"
  ##default     = aws_vpc.vpc_honeypot.id
##}


##variable "ec2_subnet_id" {
  ##description = "ID of AWS VPC subnet"
  ##default     = aws_subnet.subnet_honeynet_1.id
##}


variable "ec2_region" {
  description = "AWS region to launch servers"
  default     = "ap-southeast-2"
}


variable "key_pair" {
  default = "helmet-keypair"
}
