resource "aws_instance" "GoPhish" {
  ami           = "ami-08f0bc76ca5236b20"
  instance_type = "t2.micro"
  key_name      = var.ec2_ssh_key_name
  subnet_id     = aws_subnet.phish.id
  tags = {
    Name = "Phisherman1"

  }
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }
  user_data                   = templatefile("cloud-init.yaml")
  vpc_security_group_ids      = [aws_security_group.gophish_security_group.id]
  associate_public_ip_address = true
}
