## VPC FOR ALL PROJECT
resource "aws_vpc" "vpc_main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = local.common_tags
}

#####################################################
####### PUBLIC SUBNET SECTION ######################
#####################################################

# PUBLIC SUBNET FOR INTERNET CONNECTION
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = var.public_subnet
  availability_zone = var.aws_az

  tags = local.common_tags
}

# INTERNET GATEWAY FOR PUBLIC SUBNET
resource "aws_internet_gateway" "igw_public" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "My VPC - Internet Gateway"
  }
}

# ROUTE TABLE FOR PUBLIC SUBNET
resource "aws_route_table" "rb_public" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_public.id
  }

  tags = {
    Name = "Public Subnet Route Table."
  }
}
# ATTACH PUBLIC SUBNET ==> ROUTE TABLE
resource "aws_route_table_association" "rb_public_subnet" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rb_public.id
}

#####################################################
####### PRIVATE SUBNET SECTION ######################
#####################################################

# PRIVATE SUBNET
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = var.private_subnet
  availability_zone = var.aws_az

  tags = local.common_tags
}

# ROUTE TABLE FOR PRIVATE SUBNET
resource "aws_route_table" "rb_private" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block = var.private_subnet
    # gateway_id = aws_internet_gateway.igw_public.id
  }

  tags = {
    Name = "Private Subnet Route Table."
  }
}

# ATTACH PRIVATE SUBNET ==> ROUTE TABLE
resource "aws_route_table_association" "rb_private_subnet" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.rb_private.id
}