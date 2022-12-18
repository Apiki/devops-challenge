//Create Security Group RDS
resource "aws_security_group" "sg_db" {
  name   = "${var.environment}-sg-db-${var.region}"
  vpc_id = var.vpc_id

  ingress {
    description = "VPC bound"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
}
