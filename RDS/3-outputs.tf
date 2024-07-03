output "rds_instance_identifier" {
    value = aws_db_instance.pokemonDatabase.identifier
  
}

output "rds_resource" {
    value = aws_db_instance.pokemonDatabase
  
}