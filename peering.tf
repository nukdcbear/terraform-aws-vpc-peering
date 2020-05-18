resource "aws_vpc_peering_connection" "pc" {
  vpc_id        = module.aws_vpc_east.vpc_id
  peer_vpc_id   = module.aws_vpc_west.vpc_id
  peer_owner_id = data.aws_caller_identity.west.account_id
  peer_region   = "us-west-2"
  auto_accept   = false

  tags = {
    Name = "vpc-east to vpc-west VPC peering"
  }

  depends_on = [
    module.aws_vpc_west,
    module.aws_vpc_east,
  ]
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws.west
  vpc_peering_connection_id = aws_vpc_peering_connection.pc.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}

resource "aws_route" "vpc-peering-route-east" {
  count                     = 3
  route_table_id            = module.aws_vpc_east.public_route_table_ids[0]
  destination_cidr_block    = module.aws_vpc_west.public_subnets_cidr_blocks[count.index]
  vpc_peering_connection_id = aws_vpc_peering_connection.pc.id

  depends_on = [
    module.aws_vpc_west,
    module.aws_vpc_east,
  ]
}

resource "aws_route" "vpc-peering-route-west" {
  provider                  = aws.west
  count                     = 3
  route_table_id            = module.aws_vpc_west.public_route_table_ids[0]
  destination_cidr_block    = module.aws_vpc_east.public_subnets_cidr_blocks[count.index]
  vpc_peering_connection_id = aws_vpc_peering_connection.pc.id

  depends_on = [
    module.aws_vpc_west,
    module.aws_vpc_east,
  ]
}