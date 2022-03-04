resource "aws_db_instance" "default" {
  identifier           = var.identifier_db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.db_instance_class
  db_name              = var.db_name
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = true

  vpc_security_group_ids = [
    aws_security_group.rds_rules.id
  ]
  
  apply_immediately = true
  publicly_accessible  = true

  allocated_storage       = var.allocated_storage
  backup_retention_period = 0
  storage_type            = var.storage_type
  backup_window           = "05:00-06:00"
  maintenance_window      = "wed:06:00-wed:07:00"
}