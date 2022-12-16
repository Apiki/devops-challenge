// Create aws_ami filter to pick up the ami available in your region
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}

resource "aws_instance" "ec2_public"{
ami                         = data.aws_ami.ubuntu.id
instance_type               = var.instance_type
associate_public_ip_address = true
subnet_id                   = var.vpc.public_subnets[0]
vpc_security_group_ids      = [var.sg_pub_id]
key_name                    = var.key_name

  tags = {
    "Name" = "${var.namespace}-EC2-PUBLIC"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${var.key_name}.pem")
    host        = self.public_ip
    }


# Copies the ssh key file to home dir
  provisioner "file" {
    source      = "./${var.key_name}.pem"
    destination = "/home/ubuntu/${var.key_name}.pem"

  }
  
  //chmod key 400 on EC2 instance
  provisioner "remote-exec" {
    inline = ["chmod 400 ~/${var.key_name}.pem"]

  }

provisioner "file" {
    source      = "ansible/"
    destination = "/tmp"
  }


//# This is where we configure the instance with ansible-playbook
  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --private-key ./'${var.key_name}.pem' -u ubuntu -i '${self.public_ip},' ansible/servers.yaml --extra-vars 'domain=dominio' "    
  }

}

