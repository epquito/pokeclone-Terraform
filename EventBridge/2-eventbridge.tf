resource "aws_scheduler_schedule" "rds_snapshot_schedule" {
  name = "rds_snapshot_schedule"
  flexible_time_window {
    mode = "FLEXIBLE"
    maximum_window_in_minutes = 5
  }
  

  schedule_expression = "cron(0 * * * ? *)"


  target {
    arn = "arn:aws:scheduler:::aws-sdk:rds:createDBSnapshot"
    role_arn = aws_iam_role.eventbridge_role.arn

    input = jsonencode({
      DbInstanceIdentifier = "${var.db_instance_identifier_id}"  # Replace with the correct DB instance identifier
      DbSnapshotIdentifier = "pokeclone-db-snapshot-schedule"
    })
  }
  depends_on = [var.eventbridge_db_resource]
}