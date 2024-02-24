resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "db-subnet-group"
  subnet_ids = [
    aws_subnet.public-subnet-1.id,
    aws_subnet.public-subnet-2.id,
  ]
}

resource "aws_db_instance" "pokemonDatabase" {
  allocated_storage      = 20
  identifier             = "pokeclone-db"
  db_name                = "pokeclone_db"
  engine                 = "postgres"
  engine_version         = "12.17"
  instance_class         = "db.t2.micro"
  username               = "postgres"
  password               = "postgres"
  parameter_group_name   = "default.postgres12"
  publicly_accessible    = true
  skip_final_snapshot    = true
  deletion_protection    = false
  vpc_security_group_ids = [aws_security_group.rds_postgres_sg.id]

  db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.name
}
