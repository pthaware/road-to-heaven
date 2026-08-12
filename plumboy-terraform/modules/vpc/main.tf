# ============================================================
# VPC
# ============================================================

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}


# ============================================================
# SUBNETS
# ============================================================

# -------------------------
# Public Subnet
# -------------------------

resource "aws_subnet" "public" {
  for_each = {
    for subnet in var.public_subnets :
    subnet.cidr => subnet
  }
  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-${each.value.az}"
  }
}


# -------------------------
# Private Subnet
# -------------------------

resource "aws_subnet" "private" {
  for_each = {
    for subnet in var.private_subnets :
    subnet.cidr => subnet
  }

  vpc_id = aws_vpc.this.id

  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.vpc_name}-private-${each.value.az}"
  }
}


# ============================================================
# INTERNET GATEWAY
# ============================================================

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}


# ============================================================
# ROUTE TABLES
# ============================================================

# -------------------------
# Public Route Table
# -------------------------

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}


# -------------------------
# Private Route Table
# -------------------------

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.vpc_name}-private-rt"
  }
}


# ============================================================
# PUBLIC ROUTE
# Public Subnet → Internet Gateway
# ============================================================

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"

  gateway_id = aws_internet_gateway.this.id
}


# ============================================================
# ROUTE TABLE ASSOCIATIONS
# ============================================================

# -------------------------
# Public Subnet → Public RT
# -------------------------

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public
  subnet_id = each.value.id
  route_table_id = aws_route_table.public_rt.id
}


# -------------------------
# Private Subnet → Private RT
# -------------------------

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private
  subnet_id = each.value.id
  route_table_id = aws_route_table.private_rt.id
}
