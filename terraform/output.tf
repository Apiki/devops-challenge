
output "public_dns" {
  value = aws_instance.wordpress.public_dns
}

output "public_ip" {
  value = aws_instance.wordpress.public_ip
}