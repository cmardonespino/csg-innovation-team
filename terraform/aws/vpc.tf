locals {
  vpc_cidr_block = {
    "development" = "10.32.0.0/16"
    "staging"     = "10.33.0.0/16"
    "production"  = "10.34.0.0/16"
  }
}

resource "aws_vpc" "vpc" {
  cidr_block                       = local.vpc_cidr_block[terraform.workspace]
  assign_generated_ipv6_cidr_block = true
  enable_classiclink               = false
  enable_classiclink_dns_support   = false
  enable_dns_hostnames             = true
  enable_dns_support               = true
  instance_tenancy                 = "default"

  tags = {
    Name = "new-vpc"
  }
}