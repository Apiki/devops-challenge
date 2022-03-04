output "rds_endpoint" {
  value = aws_db_instance.default.endpoint
}

output "wordpress-private_ip" {
  value = aws_instance.wordpress-instance.private_ip
}
output "wordpress-public_ip" {
  value = aws_instance.wordpress-instance.public_ip
}

### environtment variables
resource "local_file" "environtment_variables" {
  content = templatefile("template/environment.tmpl", {
    host     = aws_db_instance.default.address,
    username = var.username,
    password = var.password,
    db_name  = var.db_name
  })
  filename = "../environment.env"
}

resource "local_file" "AnsibleInventory" {
  content = templatefile("template/inventory.tmpl", {
    host = aws_instance.wordpress-instance.public_ip
  })
  filename = "../ansible/inventory"
}
