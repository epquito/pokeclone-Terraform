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
