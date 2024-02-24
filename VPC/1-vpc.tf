resource "aws_vpc" "pokemon" {

    cidr_block = "10.0.0.0/24"
    tags = {
      Name = "pokemon"
    }
}
