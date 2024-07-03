resource "aws_cloudwatch_metric_alarm" "eks_cluster_alarm" {
  alarm_name          = var.cloudwatch_alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CallCount"
  namespace           = "AWS/Usage"
  period              = 60  # Set the appropriate period in seconds
  statistic           = "Sum"
  threshold           = 1  # Set the appropriate threshold value
  alarm_actions       = [var.eks_alarm_topic_arn]

  dimensions = {
    Type      = "API"
    Resource  = "ListClusters"
    Service   = "EKS"
    Class     = "None"
  }

  alarm_description = "Alarm for EKS Cluster API Call Count"

}

resource "aws_cloudwatch_metric_alarm" "ASG_CPUUtilization" {
  alarm_name          = var.asg_cloudwatch_alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1" // Number of consecutive periods for which the metric condition must be true
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"      // in seconds
  statistic           = "Average" // metric aggregation type
  threshold           = "25"      // threshold for triggering the alarm (75% CPU utilization)
  alarm_description   = "This alarm monitors ASG CPU utilization"
  actions_enabled     = true
  alarm_actions       = [var.asg_alarm_topic_arn] // Action to trigger SNS notification
  dimensions = {
    AutoScalingGroupName = "${var.aws_eks_asg_id}" 
  }
}