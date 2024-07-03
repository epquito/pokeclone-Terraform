resource "aws_route_table_association" "private-subnet-1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route-pokemon.id
}

resource "aws_route_table_association" "private-subnet-2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-route-pokemon.id
}

resource "aws_route_table_association" "public-subnet-1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_default_route_table.public-route-pokemon.id
}

resource "aws_route_table_association" "public-subnet-2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_default_route_table.public-route-pokemon.id
}
