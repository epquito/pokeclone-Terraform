// Create SNS topic for eks-cluster-alarms
resource "aws_sns_topic" "eks-cluster-alarms" {
  name = "eks-cluster-alarms"
}

// Subscription for SNS topic - sends notifications to the specified email
resource "aws_sns_topic_subscription" "eks_cluster_alarms_email" {
  topic_arn = aws_sns_topic.eks-cluster-alarms.arn
  protocol  = "email"
  endpoint  = "edwinquito45@gmail.com"
}

// Metric alarm for cluster list
resource "aws_cloudwatch_metric_alarm" "Cluster_list" {
  alarm_name          = "ListCluster"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CallCount"
  namespace           = "AWS/Usage"
  period              = "60"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "Alarm triggered after more than 1 cluster"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.eks-cluster-alarms.arn]
  dimensions = {
    cluster_name = aws_eks_cluster.pokemon-cluster.name
  }
}

// Metric alarm for cluster node groups
resource "aws_cloudwatch_metric_alarm" "Cluster_Node_groups" {
  alarm_name          = "Cluster_Node_Groups"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CallCount"
  namespace           = "AWS/EKS"
  period              = "60"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "Alarm triggered after more than 1 Node Group"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.eks-cluster-alarms.arn]
  dimensions = {
    cluster_name     = aws_eks_cluster.pokemon-cluster.name
    node_group_name = "pokemon-frontend-nodes"
  }
}

resource "aws_cloudwatch_metric_alarm" "Cluster_Logs_Events" {
  alarm_name          = "Cluster_Logs_Events"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "IncomingLogEvents"
  namespace           = "AWS/Logs"
  period              = "30"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "Alarm triggered from log events within cluster"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.eks-cluster-alarms.arn]
  dimensions = {
    cluster_name     = aws_eks_cluster.pokemon-cluster.name
    log_group_name = "/aws/eks/pokemon-cluster/control-plane-logs"
    
  }
}
resource "aws_cloudwatch_metric_alarm" "Cluster_Incoming_bytes" {
  alarm_name          = "Cluster_Incoming_bytes"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "IncomingBytes"
  namespace           = "AWS/Logs"
  period              = "30"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "Alarm triggered from incoming bytes within cluster"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.eks-cluster-alarms.arn]
  dimensions = {
    cluster_name     = aws_eks_cluster.pokemon-cluster.name
    log_group_name = "/aws/eks/pokemon-cluster/control-plane-logs"
    
  }
}

// CloudWatch dashboard for EKS Cluster metrics
resource "aws_cloudwatch_dashboard" "EKS_Cluster_metrics" {
  dashboard_name = "EKS-Metrics"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 6
        height = 6

        properties = {
          metrics = [
            [
              "AWS/Usage",
              "CallCount",
              "cluster_name",
              "${aws_eks_cluster.pokemon-cluster.name}"
            ],
          ]
          period = 30
          stat   = "Average"
          region = "us-east-1"
          title  = "Usage - CallCount"
        }
      },
      {
        type   = "metric"
        x      = 6
        y      = 0
        width  = 6
        height = 6

        properties = {
          metrics = [
            [
              "AWS/EKS",
              "CallCount",
              "cluster_name",
              "${aws_eks_cluster.pokemon-cluster.name}"
            ],
          ]
          period = 30
          stat   = "Average"
          region = "us-east-1"
          title  = "EKS - CallCount"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 6
        height = 6

        properties = {
          metrics = [
            [
              "AWS/Logs",
              "IncomingLogEvents",
              "cluster_name",
              "${aws_eks_cluster.pokemon-cluster.name}"
            ],
          ]
          period = 30
          stat   = "Average"
          region = "us-east-1"
          title  = "Logs - IncomingLogEvents"
        }
      },
      {
        type   = "metric"
        x      = 6
        y      = 6
        width  = 6
        height = 6

        properties = {
          metrics = [
            [
              "AWS/Logs",
              "IncomingBytes",
              "cluster_name",
              "${aws_eks_cluster.pokemon-cluster.name}"
            ],
          ]
          period = 30
          stat   = "Average"
          region = "us-east-1"
          title  = "Logs - IncomingBytes"
        }
      },
      {
        type   = "text"
        x      = 0
        y      = 12
        width  = 3
        height = 3

        properties = {
          markdown = "Pokemon cluster"
        }
      },
    ]
  })
}
