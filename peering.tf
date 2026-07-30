resource "aws_vpc_peering_connection" "default_peering" {
  count= var.is_peering_required ? 1 :0
  peer_vpc_id   = local.default_vpc
  vpc_id        = aws_vpc.main.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
  auto_accept = true
  tags = merge (
    var.peering,
    local.common_tags,
    {
        Name= "${local.common_name}-peering"
    }
  )

}
 # private route
resource "aws_route" "private" {
  count= var.is_peering_required ? 1 :0
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.default_peering[count.index].id
}


 # default route
resource "aws_route" "default" {
  count= var.is_peering_required ? 1 :0
  route_table_id            = data.aws_route_table.default.id
  destination_cidr_block    = var.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.default_peering[count.index].id
}


