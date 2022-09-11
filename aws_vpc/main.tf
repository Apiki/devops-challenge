# Criação da VPC
resource "aws_vpc" "wordpress_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "wordpress_vpc"
  }
}

# Criação da Subnet Pública
resource "aws_subnet" "wordpress_public_subnet" {
  vpc_id     = aws_vpc.wordpress_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "wordpress_public_subnet"
  }
}

# Criação do Internet Gateway
resource "aws_internet_gateway" "wordpress_igw" {
  vpc_id = aws_vpc.wordpress_vpc.id

  tags = {
    Name = "wordpress_igw"
  }
}

# Criação da Tabela de Roteamento
resource "aws_route_table" "wordpress_rt" {
  vpc_id = aws_vpc.wordpress_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wordpress_igw.id
  }

  tags = {
    Name = "wordpress_rt"
  }
}

# Criação da Rota Default para Acesso à Internet
resource "aws_route" "wordpress_routetointernet" {
  route_table_id            = aws_route_table.wordpress_rt.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.wordpress_igw.id
}

# Associação da Subnet Pública com a Tabela de Roteamento
resource "aws_route_table_association" "wordpress_pub_association" {
  subnet_id      = aws_subnet.wordpress_public_subnet.id
  route_table_id = aws_route_table.wordpress_rt.id
}