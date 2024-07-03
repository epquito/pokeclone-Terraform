# Subscribe edwinquito45@gmail.com to the SNS Topic
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.db_snapshot_event_topic.arn
  protocol  = "email"
  endpoint  = var.sns_topic_email_eventbridge
}
// Subscription for SNS topic - sends notifications to the specified email
resource "aws_sns_topic_subscription" "eks_cluster_alarms_email" {
  topic_arn = aws_sns_topic.eks-cluster-alarms.arn
  protocol  = "email"
  endpoint  = var.sns_subscription_email_EKS
}
// Subscription for SNS topic - sends notifications to the specified email
resource "aws_sns_topic_subscription" "asg_alarms_email" {
  topic_arn = aws_sns_topic.asg-alarms.arn
  protocol  = "email"
  endpoint  = var.asg_sns_subscription_email
}
