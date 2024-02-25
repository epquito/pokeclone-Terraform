resource "aws_eip" "pokemon-nat" {
    vpc = true
    tags = {
      Name = "pokemon-nat"
    }
  
}
resource "aws_nat_gateway" "pokemon-nat-gw" {
  allocation_id = aws_eip.pokemon-nat.id 
  subnet_id     = aws_subnet.public-subnet-1.id  # Corrected subnet reference
  tags = {
    Name = "pokemon-nat-gw"
  }
  depends_on = [aws_internet_gateway.pokemon-igw]  # Corrected dependency reference
}

