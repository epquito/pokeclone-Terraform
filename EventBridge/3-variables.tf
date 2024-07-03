# IAM Role for EventBridge
variable "iam_role_name" {
  description = "Name of the IAM role for EventBridge"
  type        = string
}

variable "db_instance_identifier_id" {
  description = "db instance identifier id"
  type        = string
}
variable "eventbridge_db_resource" {
    description = "Database resource so eventbridge starts up after rds is up"
  
}