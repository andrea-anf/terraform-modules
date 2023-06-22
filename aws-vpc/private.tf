resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.this.id
  count                   = var.subnets_count
  cidr_block              = cidrsubnet(var.cidr_block, var.cidr_block_newbits, count.index + var.cidr_block_netnum)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.default_tags["Project_prefix"]}-priv-subnet-${data.aws_availability_zones.available.names[count.index]}-${var.default_tags["Environment"]}"
  }
}

# Create private route tables to route traffic for private subnets
resource "aws_route_table" "private" {
  count  = length(aws_subnet.private)
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.default_tags["Project_prefix"]}-priv-route-table-${data.aws_availability_zones.available.names[count.index]}-${var.default_tags["Environment"]}"
  }
}

# Create route for NAT gateway
resource "aws_route" "nat_gateway" {
  count                  = length(aws_subnet.private)
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.this.*.id, count.index)
}

# Assign private route table to private subnets
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)

}
