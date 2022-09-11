output "ip_address" {
  value = aws_instance.wordpress_ec2.public_ip
}
