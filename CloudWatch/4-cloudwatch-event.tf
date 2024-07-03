# Create CloudWatch Events rules
resource "aws_cloudwatch_event_rule" "rds_snapshot_rule" {
  name        = var.cloudwatch_event_rule_name
  description = "Rule to trigger RDS snapshots"
  schedule_expression = var.scheduled_expression
}

# Add a target to the CloudWatch Events rule (SNS topic)
resource "aws_cloudwatch_event_target" "rds_snapshot_target" {
  rule      = aws_cloudwatch_event_rule.rds_snapshot_rule.name
  arn       = var.sns_topic_for_event_arn
}