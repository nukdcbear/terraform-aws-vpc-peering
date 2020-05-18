terraform {
  backend "s3" {
    bucket  = "dcbear-engineering-dev-tfstate"
    key     = "tfstates/demo-peered-vpc"
    region  = "us-east-2"
    encrypt = true
  }
}

module "aws_vpc_east" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  name = var.vpc-east
  cidr = var.aws_vpc_cidr_block-east

  azs = var.aws_availability_zones-east

  public_subnets = [
    cidrsubnet(var.aws_vpc_cidr_block-east, 5, 0),
    cidrsubnet(var.aws_vpc_cidr_block-east, 5, 8),
    cidrsubnet(var.aws_vpc_cidr_block-east, 5, 16),
  ]

  private_subnets = [
    cidrsubnet(var.aws_vpc_cidr_block-east, 5, 1),
    cidrsubnet(var.aws_vpc_cidr_block-east, 5, 9),
    cidrsubnet(var.aws_vpc_cidr_block-east, 5, 17),
  ]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc-east
  }
}

module "aws_vpc_west" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  providers = {
    aws = aws.west
  }

  name = var.vpc-west
  cidr = var.aws_vpc_cidr_block-west

  azs = var.aws_availability_zones-west

  public_subnets = [
    cidrsubnet(var.aws_vpc_cidr_block-west, 5, 0),
    cidrsubnet(var.aws_vpc_cidr_block-west, 5, 8),
    cidrsubnet(var.aws_vpc_cidr_block-west, 5, 16),
  ]

  private_subnets = [
    cidrsubnet(var.aws_vpc_cidr_block-west, 5, 1),
    cidrsubnet(var.aws_vpc_cidr_block-west, 5, 9),
    cidrsubnet(var.aws_vpc_cidr_block-west, 5, 17),
  ]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc-west
  }
}