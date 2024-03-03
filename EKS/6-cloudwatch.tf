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
resource "aws_cloudwatch_dashboard" "EKS-CLuster-Terraform-Pokeclone" {
  dashboard_name = "EKS-CLuster-Terraform-Pokeclone"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/Usage",       # Namespace
              "CallCount",       # Metric name
              "Type",            # Dimension name
              "API",             # Dimension value
              "Resource",        # Dimension name
              "ListClusters",    # Dimension value
              "Service",         # Dimension name
              "EKS",             # Dimension value
              "Class",           # Dimension name
              "None",            # Dimension value
            ]
          ]
          period = 60
          stat   = "Average"
          region = "us-east-1"
          title  = "List of EKS Clusters"
          view   = "singleValue"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/Usage",       # Namespace
              "CallCount",       # Metric name
              "Type",            # Dimension name
              "API",             # Dimension value
              "Resource",        # Dimension name
              "ListNodegroups",    # Dimension value
              "Service",         # Dimension name
              "EKS",             # Dimension value
              "Class",           # Dimension name
              "None",            # Dimension value
            ]
          ]
          period = 60
          stat   = "Average"
          region = "us-east-1"
          title  = "List of EKS Clusters node groups"
          view   = "singleValue"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/Logs",       # Namespace
              "IncomingBytes",       # Metric name
              "LogGroupName",        # Dimension name
              "/aws/eks/pokemon-cluster/cluster",   
            ]
          ]
          period = 60
          stat   = "Average"
          region = "us-east-1"
          title  = "Logs of eks IncomingBytes"
          view   = "singleValue"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/Logs",       # Namespace
              "IncomingLogEvents",       # Metric name
              "LogGroupName",        # Dimension name
              "/aws/eks/pokemon-cluster/cluster",   
            ]
          ]
          period = 60
          stat   = "Average"
          region = "us-east-1"
          title  = "Logs of eks IncomingLogEvents"
          view   = "singleValue"
        }
      },
    ]
  })
}
