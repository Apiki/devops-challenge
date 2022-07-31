data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] 
}

resource "aws_instance" "Apiki-aws" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = "felipe-key" 
  subnet_id = var.aws_subnet_public_id
  vpc_security_group_ids = [aws_security_group.permitir_ssh_http.id]
  associate_public_ip_address = true

  tags = {
    Name = "Apiki-aws"
  }
}

variable "aws_vpc_id" {
  default = "vpc-0917563711f0dc137" 
}

variable "aws_subnet_public_id" {
  default = "subnet-06154e684ff07fd8c" 
}

vpc_security_group_ids = [aws_security_group.permitir_ssh_http.id]