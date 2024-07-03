#private route table
resource "aws_route_table" "private-route-pokemon" {
  vpc_id = aws_vpc.pokemon.id
  
  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.pokemon-nat-gw.id
  }


  tags = {
    Name = var.private_route_table_name
  }
}





#public route table
resource "aws_default_route_table" "public-route-pokemon" {
  default_route_table_id = aws_vpc.pokemon.default_route_table_id

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pokemon-igw.id
  }

  tags = {
    Name = var.public_route_table_name
  }
}

