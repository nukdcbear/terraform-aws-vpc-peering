variable "vpc-east" {
  default = "demo-vpc-east"
}

variable "vpc-west" {
  default = "demo-vpc-west"
}

variable "aws_vpc_cidr_block-east" {
  default = "10.0.0.0/16"
}

variable "aws_vpc_cidr_block-west" {
  default = "10.1.0.0/16"
}

variable "aws_availability_zones-east" {
  type    = list(string)
  default = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

variable "aws_availability_zones-west" {
  type    = list(string)
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}