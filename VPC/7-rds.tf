# Create a DB subnet group
resource "aws_db_subnet_group" "db-subnet-group" {
  name       = var.db_subnet_group_name
  subnet_ids = [
    aws_subnet.public-subnet-1.id,
    aws_subnet.public-subnet-2.id,
  ]
}

# Create an RDS instance
resource "aws_db_instance" "pokemonDatabase" {
  allocated_storage      = 20
  identifier             = var.db_instance_identifier
  db_name                = var.db_name
  engine                 = "postgres"
  engine_version         = "12.17"
  instance_class         = "db.t2.micro"
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.postgres12"
  publicly_accessible    = true
  skip_final_snapshot    = true
  deletion_protection    = false
  vpc_security_group_ids = [aws_security_group.public_sg.id]

  db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.name
  iam_database_authentication_enabled = true

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  backup_retention_period = 1
}
# Create an SNS Topic
resource "aws_sns_topic" "db_snapshot_event_topic" {
  name = var.sns_topic_name
}

# Subscribe edwinquito45@gmail.com to the SNS Topic
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.db_snapshot_event_topic.arn
  protocol  = "email"
  endpoint  = var.sns_topic_email
}
# Create IAM Role for EventBridge
resource "aws_iam_role" "eventbridge_role" {
  name = var.iam_role_name
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "scheduler.amazonaws.com",
      },
    }],
  })
}

# Attach policies to the IAM Role
resource "aws_iam_role_policy_attachment" "eventbridge_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"  # Adjust based on your specific needs
  role       = aws_iam_role.eventbridge_role.name
}

resource "aws_scheduler_schedule" "rds_snapshot_schedule" {
  name = "rds_snapshot_schedule"
  flexible_time_window {
    mode = "FLEXIBLE"
    maximum_window_in_minutes = 5
  }
  

  schedule_expression = "cron(0/10 * * * ? *)"


  target {
    arn = "arn:aws:scheduler:::aws-sdk:rds:createDBSnapshot"
    role_arn = aws_iam_role.eventbridge_role.arn

    input = jsonencode({
      DbInstanceIdentifier = var.db_instance_identifier,  # Replace with the correct DB instance identifier
      DbSnapshotIdentifier = "pokeclone-db-snapshot-schedule"
    })
  }

  depends_on = [aws_db_instance.pokemonDatabase]
}

# Create CloudWatch Events rules
resource "aws_cloudwatch_event_rule" "rds_snapshot_rule" {
  name        = var.cloudwatch_event_rule_name
  description = "Rule to trigger RDS snapshots"
  schedule_expression = aws_scheduler_schedule.rds_snapshot_schedule.schedule_expression
}

# Add a target to the CloudWatch Events rule (SNS topic)
resource "aws_cloudwatch_event_target" "rds_snapshot_target" {
  rule      = aws_cloudwatch_event_rule.rds_snapshot_rule.name
  arn       = aws_sns_topic.db_snapshot_event_topic.arn
}

resource "aws_sns_topic_policy" "db_snapshot_event_topic_policy" {
  arn = aws_sns_topic.db_snapshot_event_topic.arn

  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "CloudWatchEventsToSNSPolicy",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "events.amazonaws.com",
        },
        Action = "sns:Publish",
        Resource = "*",
      },
    ],
  })
}

