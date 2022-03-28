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

  owners = ["099720109477"] # Canonical
}

data "template_file" "dockercompose" {
  template = file("./template/docker-compose.tpl")

  vars = {
    dbhost        = aws_db_instance.wordpress.endpoint
    dbuser        = aws_db_instance.wordpress.username
    dbpassword    = aws_db_instance.wordpress.password
    dbname        = aws_db_instance.wordpress.db_name
    external_port = var.wordpress_http
  }
}

data "template_file" "nginx_conf" {
  template = file("./template/server-conf.tpl")

  vars = {
    external_port = var.wordpress_http
  }
}

data "template_file" "userdata" {
  template = file("./template/userdata.tpl")

  vars = {
    dockercompose = data.template_file.dockercompose.rendered
    nginx_conf    = data.template_file.nginx_conf.rendered
  }

}