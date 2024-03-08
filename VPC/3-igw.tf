resource "aws_internet_gateway" "pokemon-igw" {
    vpc_id = aws_vpc.pokemon.id
    tags = {
      Name = var.internet_gateway_name
    }
}
