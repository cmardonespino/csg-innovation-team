data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["vpc"]
  }
}

data "aws_subnet_ids" "subnets" {
  vpc_id = data.aws_vpc.vpc.id

  filter {
    name   = "tag:Name"
    values = ["az*"]
  }
}