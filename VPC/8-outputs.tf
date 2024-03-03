output "vpc_id" {
    value = aws_vpc.pokemon.id
}
output "subnet_ids" {
    value = [
        aws_subnet.public-subnet-1.id,
        aws_subnet.public-subnet-2.id,
        aws_subnet.private-subnet-1.id,
        aws_subnet.private-subnet-2.id,
    ]
  
}

output "public_subnet_ids" {
    value = [
        aws_subnet.public-subnet-1.id,
        aws_subnet.public-subnet-2.id,
    ]
}

output "private_subnet_ids" {
    value = [
        aws_subnet.private-subnet-1.id,
        aws_subnet.private-subnet-2.id,
    ]
}

output "internet_gateway_id" {
    value = aws_internet_gateway.pokemon-igw.id
}

output "nat_gateway_id" {
    value = aws_nat_gateway.pokemon-nat-gw.id
}

output "private_route_table_id" {
    value = aws_route_table.private-route-pokemon.id
}

output "public_route_table_id" {
    value = aws_route_table.public-route-pokemon.id
}

output "public_security_group_id" {
    value = aws_security_group.public_sg.id
}

output "rds_postgres_security_group_id" {
    value = aws_security_group.rds_postgres_sg.id
}

output "db_subnet_group_name" {
    value = aws_db_subnet_group.db-subnet-group.name
}

output "db_instance_endpoint" {
    value = aws_db_instance.pokemonDatabase.endpoint
}

output "db_instance_identifier" {
    value = aws_db_instance.pokemonDatabase.id
  
}