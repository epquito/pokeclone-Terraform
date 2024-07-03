resource "aws_default_network_acl" "public_pokemon_acl" {
    default_network_acl_id = aws_vpc.pokemon.default_network_acl_id
    subnet_ids             = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]

    # Allow HTTP to all
    ingress {
        protocol   = "-1"
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }

    # Allow all outbound traffic
    egress {
        protocol   = "-1"
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }

    tags = {
        Name = var.public_pokemon_acl
    }
}








resource "aws_network_acl" "private_pokemon_acl" {
    vpc_id = aws_vpc.pokemon.id
    subnet_ids = [ aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id ]
    ingress {
        protocol   = "-1"
        rule_no    = 100
        action     = "allow"
        cidr_block = var.vpc_cidr_block
        from_port  = 0
        to_port    = 0
    }


 
    egress {
        protocol   = "-1"
        rule_no    = 100
        action     = "allow"
        cidr_block = var.vpc_cidr_block
        from_port  = 0
        to_port    = 0
    }

    tags = {
        Name = var.private_pokemon_acl

    }

  
}
