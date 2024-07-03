#eventbridge sns

output "sns_topic_event_arn" {
    value = aws_sns_topic.db_snapshot_event_topic.arn
  
}
output "sns_topic_event_id" {
    value = aws_sns_topic.db_snapshot_event_topic.id
  
}
#eventbridge subs
output "sns_topic_email_arn" {
    value = aws_sns_topic_subscription.email_subscription.arn
  
}
output "sns_topic_email_id" {
    value = aws_sns_topic_subscription.email_subscription.id
  
}

#EKS topic
output "sns_topic_EKS_ID" {
    value = aws_sns_topic.eks-cluster-alarms.id 
  
}

output "sns_topic_EKS_arn" {
    value = aws_sns_topic.eks-cluster-alarms.arn
  
}


#ASG of EKS topic

output "sns_topic_ASG_ID" {
    value = aws_sns_topic.asg-alarms.id
  
}
output "sns_topic_ASG_arn" {
    value = aws_sns_topic.asg-alarms.arn
  
}
