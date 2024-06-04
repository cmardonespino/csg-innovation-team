locals {
  cidr_blocks = {
    "development" = "10.32"
    "staging"     = "10.33"
    "production"  = "10.34"
  }

  cidr_block = "${local.cidr_blocks[terraform.workspace]}.0.0/16"
}

resource "aws_subnet" "public" {
  count = length(var.availability_zones["us-east-2"])

  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = element(var.availability_zones["us-east-2"], count.index)
  cidr_block              = cidrsubnet(local.cidr_block, 8, count.index)
  map_public_ip_on_launch = true

  tags = {
    "Name" = "public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count = length(var.availability_zones["us-east-2"])

  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = element(var.availability_zones["us-east-2"], count.index)
  cidr_block              = cidrsubnet(local.cidr_block, 8, count.index + 3)
  map_public_ip_on_launch = false

  tags = {
    "Name" = "private-subnet-${count.index}"
  }
}