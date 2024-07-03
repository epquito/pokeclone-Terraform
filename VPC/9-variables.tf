
# VPC
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string

}

variable "vpc_name" {
  description = "how the vpc will shouw up on the AWS console"
  type = string

  
}

# Private Subnet 1
variable "private_subnet1_cidr_block" {
  description = "CIDR block for private subnet 1"
  type        = string

}
variable "private_subnet1_az" {
  description = "subnet availibility zone"
  type = string

  
}

# Private Subnet 2
variable "private_subnet2_cidr_block" {
  description = "CIDR block for private subnet 2"
  type        = string

}
variable "private_subnet2_az" {
  description = "subnet availibility zone"
  type = string

  
}

# Public Subnet 1
variable "public_subnet1_cidr_block" {
  description = "CIDR block for public subnet 1"
  type        = string

}
variable "public_subnet1_az" {
  description = "subnet availibility zone"
  type = string

  
}

# Public Subnet 2
variable "public_subnet2_cidr_block" {
  description = "CIDR block for public subnet 2"
  type        = string

}
variable "public_subnet2_az" {
  description = "subnet availibility zone"
  type = string
  
}

# Internet Gateway
variable "internet_gateway_name" {
  description = "Name of the Internet Gateway"
  type        = string
}

# Elastic IP
variable "nat_gateway_eip_name" {
  description = "Name of the Elastic IP for NAT Gateway"
  type        = string
}

# NAT Gateway
variable "nat_gateway_name" {
  description = "Name of the NAT Gateway"
  type        = string
}

# Route Tables
variable "private_route_table_name" {
  description = "Name of the private route table"
  type        = string
}

variable "public_route_table_name" {
  description = "Name of the public route table"
  type        = string
}

## Route table ACL

variable "public_pokemon_acl" {
  description = "public netwrok acl name"
  type = string
  
}
variable "private_pokemon_acl" {
  description = "public netwrok acl name"
  type = string
  
}


# Security Groups
variable "public_security_group_name" {
  description = "Name of the public security group"
  type        = string
}

variable "operating_system_ip" {
  description = "personal ipv4"
  type = string
  
}

variable "private_security_group_name" {
  description = "Name of the private security group"
  type        = string
}


