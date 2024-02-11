

resource "aws_instance" "Phisherman1" {
  ami           = "ami-03cbc6cddb06af2c2"
  instance_type = "t2.micro"
  key_name      = var.key_pair
  subnet_id     = aws_subnet.phishnet.id
  tags = {
    Name = "GoPhish1"

  }
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }
  user_data                   = file("cloud-init.yaml")
  vpc_security_group_ids      = [aws_security_group.phish.id]
  associate_public_ip_address = true
}
