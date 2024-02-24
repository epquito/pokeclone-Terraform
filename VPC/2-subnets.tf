resource "aws_subnet" "private-subnet-1" {
  vpc_id = aws_vpc.pokemon.id 
  cidr_block = "10.0.0.0/26"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "private-subnet-1"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo" = "owned"

  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id = aws_vpc.pokemon.id 
  cidr_block = "10.0.0.64/26"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "private-subnet-2"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo" = "owned"

  }
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id = aws_vpc.pokemon.id 
  cidr_block = "10.0.0.128/26"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "public-subnet-1"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo" = "owned"

  }
}
resource "aws_subnet" "public-subnet-2" {
  vpc_id = aws_vpc.pokemon.id 
  cidr_block = "10.0.0.192/26"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "public-subnet-2"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo" = "owned"

  }
}
