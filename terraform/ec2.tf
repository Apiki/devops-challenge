resource "aws_key_pair" "apiki-key" {
  key_name   = "devops-apiki-key"
  public_key = file("../keys/devops-apiki-key.pub")
}

resource "aws_instance" "wordpress-instance" {
  ami           = var.aws_amis[var.aws_region]
  instance_type = var.instance_type
  key_name      = aws_key_pair.apiki-key.key_name
  vpc_security_group_ids = [
    aws_security_group.wordpress_rules.id
  ]

  tags = {
    Name = "wordpress"
  }

  user_data = file("cloud_config-wordpress.yml")

  root_block_device {
    delete_on_termination = false
    volume_size           = 80
  }
}

