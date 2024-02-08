output "Admin_UI" {
  value = [for i in aws_instance.GoPhish : "https://${i.public_dns}:64294/"]
}
