variable "availability_zones" {
  description = "The AZ from AWS Subnets"
  type        = map(list(string))
  default = {
    us-east-2 = ["us-east-2a", "us-east-2b", "us-east-2c"]
  }
}

resource "aws_route_table" "public" {
  count = length(var.availability_zones["us-east-2"])

  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "public-routetable-${count.index}"
  }
}

# Internet access
resource "aws_route" "public_route" {
  count = length(var.availability_zones["us-east-2"])

  route_table_id         = element(aws_route_table.public.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_route_table.public]
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_routing_table" {
  count          = length(var.availability_zones["us-east-2"])
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = element(aws_route_table.public.*.id, count.index)
}

resource "aws_route_table" "private" {
  count = length(var.availability_zones["us-east-2"])

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.gw.*.id, count.index)
  }

  tags = {
      "Name" = "private-routetable-${count.index}"
    }
}

resource "aws_route_table_association" "private_routing_table" {
  count          = length(var.availability_zones["us-east-2"])
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}