# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    local.common_tags,
    {
      Name = "${lower(local.name_prefix)}-${var.region}"
    },
    {
      Tier = "dev"
    }
  )
}

# Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    local.common_tags,
    {
      Name = "${lower(local.name_prefix)}-igw-${var.region}"
    }
  )
}

# Private subnets
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.vpc.id

  count             = length(var.private_subnets)
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.azs, count.index)


  tags = merge(
    local.common_tags,
    {
      Name = "${lower(local.name_prefix)}-subnet-private-${count.index}-${var.azs[count.index]}-${var.region}"
    },
    {
      Tier = "private"
    }
  )
}

# Public subnets
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.vpc.id

  count             = length(var.public_subnets)
  cidr_block        = element(var.public_subnets, count.index)
  availability_zone = element(var.azs, count.index)

  tags = merge(
    local.common_tags,
    {
      Name = "${lower(local.name_prefix)}-subnet-public-${count.index}-${var.azs[count.index]}-${var.region}"
    },
    {
      Tier = "public"
    }
  )
}

# Public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    local.common_tags,
    {
      Name = "${lower(local.name_prefix)}-rt-public-${var.region}"
    },
    {
      Tier = "public"
    }
  )
}

# Public route
resource "aws_route" "public_routes" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Route table association with public subnets
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private route table
resource "aws_route_table" "private" {
  count  = var.single_natgw ? 1 : length(var.public_subnets)
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    local.common_tags,
    {
      Name = "${lower(local.name_prefix)}-rt-private-${count.index}-${var.region}"
    },
    {
      Tier = "private"
    }
  )
}

# Public route
resource "aws_route" "private_routes" {
  count                  = var.single_natgw ? 1 : length(var.public_subnets)
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = element(aws_nat_gateway.nat1.*.id, count.index)
}

# Route table association with private subnets
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = var.single_natgw ? aws_route_table.private[0].id : element(aws_route_table.private.*.id, count.index)
}

# Nat gateway
resource "aws_nat_gateway" "nat1" {
  count         = var.single_natgw ? 1 : length(var.public_subnets)
  allocation_id = aws_eip.elastic1[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  depends_on    = [aws_internet_gateway.igw]
}

# Elastic API for gateway
resource "aws_eip" "elastic1" {
  count = var.single_natgw ? 1 : length(var.public_subnets)
  vpc   = true
}
