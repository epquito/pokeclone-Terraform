resource "aws_eip" "pokemon-nat" {
    domain = "vpc"
    tags = {
      Name = var.nat_gateway_eip_name
    }
  
}
resource "aws_nat_gateway" "pokemon-nat-gw" {
  allocation_id = aws_eip.pokemon-nat.id 
  subnet_id     = aws_subnet.public-subnet-1.id  # Corrected subnet reference
  tags = {
    Name = var.nat_gateway_name
  }
  depends_on = [aws_internet_gateway.pokemon-igw]  # Corrected dependency reference
}

