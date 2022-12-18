//Create Aurora MySql RDS
resource "aws_rds_cluster" "wordpress" {
  cluster_identifier     = var.cluster_identifier
  engine                 = var.engine
  engine_version         = var.engine_version
  database_name          = aws_ssm_parameter.dbname.value
  master_username        = aws_ssm_parameter.dbuser.value
  master_password        = aws_ssm_parameter.dbpassword.value
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.id
  engine_mode            = var.engine_mode
  vpc_security_group_ids = [aws_security_group.sg_db.id]
  skip_final_snapshot    = true
}
# Create DB Subnet
resource "aws_db_subnet_group" "db_subnet" {
  name       = "${var.environment}-subnet-db-${var.region}"
  subnet_ids = var.subnet_ids
}

resource "aws_ssm_parameter" "dbhost" {
  name  = "/app/wordpress/DATABASE_HOST"
  type  = "String"
  value = aws_rds_cluster.wordpress.endpoint
}

resource "aws_ssm_parameter" "dbname" {
  name  = "/app/wordpress/DATABASE_NAME"
  type  = "String"
  value = var.database_name
}

resource "aws_ssm_parameter" "dbuser" {
  name  = "/app/wordpress/DATABASE_MASTER_USERNAME"
  type  = "String"
  value = var.master_username
}

resource "aws_ssm_parameter" "dbpassword" {
  name  = "/app/wordpress/DATABASE_MASTER_PASSWORD"
  type  = "SecureString"
  value = random_password.password.result
}

#Random password db password
resource "random_password" "password" {
  length  = 16
  special = false
}
