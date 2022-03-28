#-----------------------------VPC-----------------------------
resource "aws_vpc" "wordpress_vpc" {
  cidr_block           = var.aws_vpc_ip
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "Wordpress VPC"
  }
}

#-----------------------------Subnet-----------------------------
resource "aws_subnet" "wordpress_sub_1" {
  vpc_id            = aws_vpc.wordpress_vpc.id
  cidr_block        = var.aws_vpc_ip1
  availability_zone = var.aws_zone1

  tags = {
    Name = "Wordpress Sub-rede 1"
  }
}

resource "aws_subnet" "wordpress_sub_2" {
  vpc_id            = aws_vpc.wordpress_vpc.id
  cidr_block        = var.aws_vpc_ip2
  availability_zone = var.aws_zone2

  tags = {
    Name = "Wordpress Sub-rede 2"
  }
}


resource "aws_db_subnet_group" "wordpress_db_sub" {
  name       = "wp-db"
  subnet_ids = [aws_subnet.wordpress_sub_1.id, aws_subnet.wordpress_sub_2.id]

  tags = {
    Name = "Wordpress Sub-rede DB"
  }
}

#-----------------------------Security Group DB-----------------------------
resource "aws_security_group" "rds_secgrp" {
  name        = "RDS Security Group"
  description = "RDS Security Group - Wordpress"
  vpc_id      = aws_vpc.wordpress_vpc.id

  ingress {
    description = "DB Port"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.wordpress_vpc.cidr_block]
  }

}


resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_vpc.wordpress_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.wordpress_gw.id
}


resource "aws_internet_gateway" "wordpress_gw" {
  vpc_id = aws_vpc.wordpress_vpc.id

  tags = {
    Name = "Wordpress Internet Gateway"
  }
}

#-----------------------------DB-----------------------------
resource "aws_db_instance" "wordpress" {
  identifier             = "wordpress-apiki-db"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = var.aws_db_instance_type
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.wordpress_db_sub.name
  vpc_security_group_ids = [aws_security_group.rds_secgrp.id]
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
}


resource "tls_private_key" "wordpress_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "wordpress_pv" {
  key_name   = "wordpress-key"
  public_key = tls_private_key.wordpress_key.public_key_openssh
}

resource "local_sensitive_file" "pem_file" {
  filename             = "./${aws_key_pair.wordpress_pv.key_name}.pem"
  file_permission      = "600"
  directory_permission = "700"
  content              = tls_private_key.wordpress_key.private_key_pem
}

resource "aws_instance" "wordpress" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.aws_instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.wordpress_sub_1.id
  security_groups             = [aws_security_group.ec2_secgrp.id]
  key_name                    = aws_key_pair.wordpress_pv.key_name
  user_data                   = data.template_file.userdata.rendered

  tags = {
    Name = "wordpress-instance-apiki"
  }
}

resource "aws_security_group" "ec2_secgrp" {
  name        = "wordpress-instance-secgrp"
  description = "wordpress instance secgrp"
  vpc_id      = aws_vpc.wordpress_vpc.id

  ingress {
    from_port   = var.wordpress_http
    to_port     = var.wordpress_http
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
