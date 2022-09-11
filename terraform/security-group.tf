resource "aws_security_group" "allow_http_and_ssh" {
  name        = "allow_http_and_ssh"
  description = "Allow http and ssh inbound traffic"
  vpc_id = aws_vpc.vpc_main.id

  # Allow HTTP from anywhere
  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  # Allow SSH from anywhere
  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] #Could be limited to only vpc cidr block
    ipv6_cidr_blocks = ["::/0"]
  }
  
  # RDS SG
  ingress {
    description      = "RDS Mysql"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] #Could be limited to only vpc cidr block
    ipv6_cidr_blocks = ["::/0"]
  }


  tags = {
    Name = "allow_tls"
  }
}