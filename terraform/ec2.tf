data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["099720109477"] #Ubuntu
}

resource "aws_instance" "wordpress" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "apiki"

  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id,
    aws_security_group.allow_http.id,
    aws_security_group.allow_https.id
  ]
  tags = {
    Name        = "wordpress-server"
    environment = "Apiki-DevOps-Challenge"
  }
}
