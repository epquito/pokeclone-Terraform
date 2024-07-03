output "private_subnet_1_id" {
    value = aws_subnet.private-subnet-1.id
  
}
output "private_subnet_2_id" {
    value = aws_subnet.private-subnet-2.id
  
}
output "public_subnet_1_id" {
    value = aws_subnet.public-subnet-1.id
  
}
output "public_subnet_2_id" {
    value = aws_subnet.public-subnet-2.id
}

output "public_security_group" {
    value = [ aws_security_group.public_sg.id ]
  
}
output "private_security_group" {
    value = aws_security_group.private_sg.id
  
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
output "vpc_id" {
    value = aws_vpc.pokemon.id
  
}
