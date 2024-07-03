# Create an SNS Topic
resource "aws_sns_topic" "db_snapshot_event_topic" {
  name = var.sns_topic_name_eventbridge
}
// Create SNS topic for eks-cluster-alarms
resource "aws_sns_topic" "eks-cluster-alarms" {
  name = var.sns_topic_name_eks
}
// Create SNS topic for auto scaling groups in eks
resource "aws_sns_topic" "asg-alarms" {
  name = var.asg_sns_topic_name
}
