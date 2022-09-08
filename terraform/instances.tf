
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu_ami.id
  instance_type = var.instance_type
  vpc_security_group_ids      = ["${aws_security_group.allow_http_and_ssh.id}"]
  subnet_id                   = "${aws_subnet.public_subnet.id}"
  associate_public_ip_address = true
  key_name = "madra"

  # TODO: Consider how to clean this up

  # user_data = file("init.sh")

  # provisioner "remote-exec" {
  #   inline = ["sudo apt update", "sudo apt install python3 -y", "echo Done!"]

  #   connection {
  #     host        = self.public_dns
  #     type        = "ssh"
  #     user        = "ubuntu"
  #     private_key = file("~/.ssh/madra.pem")
  #   }
  # }

  # provisioner "local-exec" {
    # command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i '${self.public_dns}', --private-key file('~/.ssh/madra.pem') ../ansible/main.yml"
  # }
  
  tags = {
    Name = "HelloWorld"
  }
}
