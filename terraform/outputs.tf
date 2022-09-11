output "public_ip" {
  value = aws_instance.web.public_ip
}
output "public_dns" {
  value = aws_instance.web.public_dns
}
output "private_ip" {
  value = aws_instance.web.private_ip
}
output "rds_endpoint" {
  value = aws_db_instance.mysql_db.endpoint
}