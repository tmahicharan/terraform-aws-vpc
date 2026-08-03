    #vpc
resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames= true

  tags = merge (
    var.vpc_tags,
    local.common_tags,
    {
        Name= "${local.common_name}-vpc"
    }
  )
}

    #gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

 tags = merge (
    var.ig,
    local.common_tags,
    {
        Name= "${local.common_name}-vpc"
    }
  )
}

    #public_subnet
resource "aws_subnet" "public" {
  count= length(var.public_subnet)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet[count.index]
  availability_zone = local.az_names[count.index]
  map_public_ip_on_launch = true

  tags = merge (
    var.public_subnet_tags,
    local.common_tags,
    {
        Name= "${local.common_name}-public-${local.az_names[count.index]}"
    }
  )
}

    #private_subnet
resource "aws_subnet" "private" {
  count= length(var.private_subnet)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet[count.index]
  availability_zone = local.az_names[count.index]


  tags = merge (
    var.private_subnet_tags,
    local.common_tags,
    {
        Name= "${local.common_name}-private-${local.az_names[count.index]}"
    }
  )
}

    #database_subnet
resource "aws_subnet" "database" {
  count= length(var.database_subnet)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet[count.index]
  availability_zone = local.az_names[count.index]


  tags = merge (
    var.database_subnet_tags,
    local.common_tags,
    {
        Name= "${local.common_name}-database-${local.az_names[count.index]}"
    }
  )
}

    #publicroutetable
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

 tags = merge (
    var.public_route_table,
    local.common_tags,
    {
        Name= "${local.common_name}-public"
    }
  )
}

    #privateroutetable
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

 tags = merge (
    var.private_route_table,
    local.common_tags,
    {
        Name= "${local.common_name}-private"
    }
  )
}

    #databaseroutetable
resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

 tags = merge (
    var.database_route_table,
    local.common_tags,
    {
        Name= "${local.common_name}-database"
    }
  )
}


    #public route
resource "aws_route" "public" {
  route_table_id              =aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id      = aws_internet_gateway.gw.id
}


    #elastic ip
resource "aws_eip" "nat" {
  domain   = "vpc"
  tags = merge (
   var.elastic_ipe,
    local.common_tags,
    {
       Name= "${local.common_name}-elastic_ip"
    }
  )
}

    #NAT
resource "aws_nat_gateway" "nat" {
 allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge (
  var.nat_tags,
  local.common_tags,
  {
   Name= "${local.common_name}-elastic_ip"
  }
 )

  depends_on = [aws_internet_gateway.gw]
}

    #private_route
resource "aws_route" "private" {
  route_table_id              =aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id      = aws_nat_gateway.nat.id
}

    #private_route
resource "aws_route" "database" {
  route_table_id              =aws_route_table.database.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id      = aws_nat_gateway.nat.id
}

  #public association
resource "aws_route_table_association" "public" {
  count=length(var.public_subnet)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

  #private association
resource "aws_route_table_association" "private" {
  count=length(var.private_subnet)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

  #database association
resource "aws_route_table_association" "database" {
  count = length(var.database_subnet)
  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database.id
}