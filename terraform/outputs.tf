output "public_ip" {
  value = aws_instance.wordpress.public_ip
}

output "public_dns" {
  value = aws_instance.wordpress.public_dns
}

output "key_pair_pv" {
  value = aws_key_pair.wordpress_pv.public_key
}
