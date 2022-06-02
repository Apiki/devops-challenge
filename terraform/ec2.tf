data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }

    owners = ["099720109477"] #Ubuntu
}

resource "aws_instance" "wordpress" {
    ami     = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_http.id, aws_security_group.allow_https.id]
    key_name = "apiki"

    tags = {
        Name        = "wordpress-server"
        environment  = "Apiki-DevOps-Challenge"
    }
}

resource "aws_security_group" "allow_ssh" {
    name = "allow_ssh"
    description = "Libera SSH inbound"
    
    ingress {
        description = "SSH da VPC"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    tags = {
        Name = "allow_ssh"
        environment = "Apiki-DevOps-Challenge"
    }
}

resource "aws_security_group" "allow_http" {
    name = "allow_http"
    description = "Libera HTTP inbound"
    
    ingress {
        description = "HTTP da VPC"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    tags = {
        Name = "allow_http"
        environment = "Apiki-DevOps-Challenge"
    }
}

resource "aws_security_group" "allow_https" {
    name = "allow_https"
    description = "Libera HTTPS inbound"
    
    ingress {
        description = "HTTPS da VPC"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    tags = {
        Name = "allow_https"
        environment = "Apiki-DevOps-Challenge"
    }
}