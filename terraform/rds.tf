resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds_subnet_group"
  subnet_ids = aws_subnet.private_subnet.*.id

  tags = {
    Name = "rds_subnet_group"
  }
}

resource "aws_db_instance" "mysql_db" {
  allocated_storage = var.allocated_storage
  storage_type = var.storage_type
  engine = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  db_name = var.name
  username = var.username
  password = var.password
  port = var.port
  identifier = var.identifier
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot = var.skip_final_snapshot
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  # subnet_ids = [aws_subnet.private_subnet.id]
}