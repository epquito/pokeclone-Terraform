resource "aws_security_group" "public_sg" {
    name        = var.public_security_group_name
    description = "Public Security Group"
    vpc_id      = aws_vpc.pokemon.id  # Replace with your VPC ID

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = var.public_security_group_name
    }
}

resource "aws_security_group" "private_sg" {
    name        = var.private_security_group_name
    description = "Security Group for private_sg"
    vpc_id      = aws_vpc.pokemon.id  # Replace with your VPC ID

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = var.private_security_group_name
    }
}
