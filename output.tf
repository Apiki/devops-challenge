output "WORDPRESS_DB_HOST" {
  description = "The connection endpoint"
  value       = [aws_db_instance.wordpress_apiki.endpoint]
}

output "public_dns" {
  value = aws_instance.Wordpress_Apiki.public_dns
}


