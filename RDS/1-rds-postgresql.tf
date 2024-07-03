# Create a DB subnet group
resource "aws_db_subnet_group" "db-subnet-group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.rds_subnet_group_ids
}

# Create an RDS instance
resource "aws_db_instance" "pokemonDatabase" {
  allocated_storage      = 20
  identifier             = var.db_instance_identifier
  db_name                = var.db_name
  engine                 = "postgres"
  engine_version         = "12.17"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.postgres12"
  publicly_accessible    = true
  skip_final_snapshot    = true
  deletion_protection    = false
  vpc_security_group_ids = ["${var.rds-security_ids}"]

  db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.name
  iam_database_authentication_enabled = true

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  backup_retention_period = 1
}