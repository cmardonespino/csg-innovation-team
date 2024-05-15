resource "aws_eip" "eip" {
  count                     = length(var.availability_zones["us-east-2"])
  associate_with_private_ip = true

  tags = {
      "Name" = "eip-${count.index}"
    }
}

resource "aws_nat_gateway" "gw" {
  count         = length(var.availability_zones["us-east-2"])
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.eip.*.id, count.index)
}