resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.default_tags["Project_prefix"]}-igw-${var.default_tags["Environment"]}"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  count                   = var.subnets_count
  cidr_block              = cidrsubnet(var.cidr_block, var.cidr_block_newbits, count.index + var.cidr_block_netnum)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.default_tags["Project_prefix"]}-pub-subnet-${data.aws_availability_zones.available.names[count.index]}-${var.default_tags["Environment"]}"
  }
}

# Create public route tables to route traffic for public subnets
resource "aws_route_table" "public" {
  count  = length(aws_subnet.public)
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.default_tags["Project_prefix"]}-pub-route-table-${data.aws_availability_zones.available.names[count.index]}-${var.default_tags["Environment"]}"
  }
}

# Create route for Internet Gateway
resource "aws_route" "internet_gateway" {
  count                  = length(aws_route_table.public)
  route_table_id         = element(aws_route_table.public.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

# Assign public route table to public subnets
resource "aws_route_table_association" "public" {
  count          = length(aws_route_table.public)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = element(aws_route_table.public.*.id, count.index)
}

# Create nat gateway, attach an ElasticIP (eip) and assign one for each subnet
resource "aws_nat_gateway" "this" {
  count         = length(aws_subnet.public)
  allocation_id = element(aws_eip.nat_eip.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
}

# Create Elastic IP for each nat gateway
resource "aws_eip" "nat_eip" {
  count      = length(aws_subnet.public)
  vpc        = true
  depends_on = [aws_internet_gateway.this]
}