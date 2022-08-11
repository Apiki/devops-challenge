resource "aws_key_pair" "apiki" {
  key_name   = "aws-apiki"
  public_key = file("./aws-apiki.pub")
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] # owner Ubuntu-AWs us-east-2
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.apiki.key_name

  tags = {
    Name    = "Desafio DevOps"
    Empresa = "APIKI"
    Iac     = "Terraform"
  }
}

