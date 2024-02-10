output "instance_public_ip" {
  value = aws_instance.Phisherman1.public_ip
  description = "Public IP of the EC2 instance"
}

output "instance_url" {
  value = "http://${aws_instance.Phisherman1.public_ip}"
  description = "URL to access the NGINX server on the EC2 instance"
}
