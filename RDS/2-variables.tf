# RDS
variable "db_subnet_group_name" {
  description = "Name of the RDS DB subnet group"
  type        = string

}
variable "rds_subnet_group_ids" {
    type = list(string)
    description = "list of subnet ids"
  
}

variable "db_instance_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
}

variable "db_name" {
  description = "Name of the RDS database"
  type        = string
}

variable "db_username" {
  description = "Username for the RDS instance"
  type        = string
}

variable "db_password" {
  description = "Password for the RDS instance"
  type        = string
}
variable "rds-security_ids" {
    description = "list of security group IDs"
}
