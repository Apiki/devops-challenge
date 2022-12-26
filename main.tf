resource "aws_db_instance" "wordpress_apiki" {
  identifier             = "wordpressapiki"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0.27"
  instance_class         = "db.t3.micro"
  db_name                = "wordpress"
  username               = "wordpress"
  password               = "wordpress"
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot    = true

  tags = {
    Name = "Wordpress_Apiki"
  }
}

resource "aws_instance" "Wordpress_Apiki" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = "kpApiki"
  vpc_security_group_ids      = [(aws_security_group.Wordpress_Apiki_SG.name), (aws_security_group.Wordpress_Apiki_SG.name)]
  associate_public_ip_address = true
  tags = {
    Name = "Wordpress_Apiki"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/ec2/kpApiki.pem")
    host        = self.public_dns
  }

  provisioner "local-exec" {
    command = "echo WORDPRESS_DB_HOST: ${aws_db_instance.wordpress_apiki.endpoint} >> ./docker/variables.env"
  }

  provisioner "file" {
    source      = "docker/docker-compose.yml"
    destination = "/home/ubuntu/docker-compose.yml"
  }

  provisioner "file" {
    source      = "docker/nginx.conf"
    destination = "/home/ubuntu/nginx.conf"
  }

  #  provisioner "file" {
  #    source      = "database.env"
  #    destination = "/home/ubuntu/database.env"
  #  }

  provisioner "file" {
    source      = "docker/variables.env"
    destination = "/home/ubuntu/variables.env"
  }

  user_data = file("deploy.sh")
}