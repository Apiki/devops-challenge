provider "aws" {
  region  = "us-west-2"
}

resource "aws_instance" "wp_latest" {
  ami = "${var.ami.ubuntu18lts}"
  instance_type = "${var.instance.free}"
  key_name = "apiki-devops-challenge"
  user_data = "${file("init.sh")}"
  tags = {
    Name = "ec2-apiki-devops-challenge"
  }
  vpc_security_group_ids = [aws_security_group.sg_apiki_devops_challenge.id]
}