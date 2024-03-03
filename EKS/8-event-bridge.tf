resource "aws_cloudwatch_event_rule" "rds_snapshot" {
  name        = "capture-rds-snapshot-events"
  description = "Capture RDS snapshot events for specific RDS instance"
  schedule_expression = "cron(0 0 ? * 6 *)" # Run every Saturday at midnight (UTC)

  event_pattern = jsonencode({
    source      = ["aws.rds"],
    detail_type = ["RDS DB Instance Event"],
    detail = {
      EventCategories   = ["snapshot"],
      SourceIdentifier  = ["${module.VPC.db_instance_identifier}"]  # Replace with your specific RDS instance identifier
    }
  })
}

resource "aws_sns_topic" "rds_snapshot_topic" {
  name = "rds-snapshot-topic"
}

resource "aws_cloudwatch_event_target" "rds_snapshot_target" {
  target_id = "RDSSnapshotTarget"
  rule      = aws_cloudwatch_event_rule.rds_snapshot.name
  arn       = aws_sns_topic.rds_snapshot_topic.arn
}
