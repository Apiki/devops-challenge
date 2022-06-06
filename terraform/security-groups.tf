resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Libera SSH inbound"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "allow_ssh"
    environment = "Apiki-DevOps-Challenge"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Libera HTTP inbound"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "allow_http"
    environment = "Apiki-DevOps-Challenge"
  }
}

resource "aws_security_group" "allow_https" {
  name        = "allow_https"
  description = "Libera HTTPS inbound"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "allow_https"
    environment = "Apiki-DevOps-Challenge"
  }
}