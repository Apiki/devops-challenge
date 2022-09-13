
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu_ami.id
  instance_type = var.instance_type
  vpc_security_group_ids      = ["${aws_security_group.allow_http_and_ssh.id}"]
  subnet_id                   = "${aws_subnet.public_subnet.id}"
  associate_public_ip_address = true
  key_name = "madra"
  
  tags = {
    Name = "HelloWorld"
  }
}
