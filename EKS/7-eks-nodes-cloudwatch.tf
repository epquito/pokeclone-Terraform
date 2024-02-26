// Create SNS topic for auto scaling groups in eks
resource "aws_sns_topic" "asg-alarms" {
  name = "eks-cluster-alarms"
}

// Subscription for SNS topic - sends notifications to the specified email
resource "aws_sns_topic_subscription" "asg_alarms_email" {
  topic_arn = aws_sns_topic.asg-alarms.arn
  protocol  = "email"
  endpoint  = "edwinquito45@gmail.com"
}

// Metric alarm for ASG CPUUTILIZATION
resource "aws_cloudwatch_metric_alarm" "ASG_CPUUtilization" {
  alarm_name          = "ASG_CPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "30"
  statistic           = "Average"
  threshold           = "25"
  alarm_description   = "Alarm triggered after CPUUtilization is over or at 25 percent"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.asg-alarms.arn]
  dimensions = {
    AutoScalingGroupName = aws_eks_node_group.pokemon-frontend-nodes.node_group_name
  }
}

// Metric alarm for ASG CPUUTILIZATION
resource "aws_cloudwatch_metric_alarm" "ASG_DiskReadOps" {
  alarm_name          = "ASG_DiskReadOps"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "DiskReadOps"
  namespace           = "AWS/EC2"
  period              = "30"
  statistic           = "Average"
  threshold           = "25"
  alarm_description   = "Alarm triggered after DiskReadOps is over or at 25 percent"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.asg-alarms.arn]
  dimensions = {
    AutoScalingGroupName = aws_eks_node_group.pokemon-frontend-nodes.node_group_name
  }
}

// Metric alarm for ASG CPUUTILIZATION
resource "aws_cloudwatch_metric_alarm" "ASG_NetworkPacketsOut" {
  alarm_name          = "ASG_NetworkPacketsOut"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "NetworkPacketsOut"
  namespace           = "AWS/EC2"
  period              = "30"
  statistic           = "Average"
  threshold           = "25"
  alarm_description   = "Alarm triggered after NetworkPacketsOut is over or at 25 percent"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.asg-alarms.arn]
  dimensions = {
    AutoScalingGroupName = aws_eks_node_group.pokemon-frontend-nodes.node_group_name
  }
}
resource "aws_cloudwatch_metric_alarm" "ASG_DiskWriteBytes" {
  alarm_name          = "ASG_DiskWriteBytes"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "DiskWriteBytes"
  namespace           = "AWS/EC2"
  period              = "30"
  statistic           = "Average"
  threshold           = "25"
  alarm_description   = "Alarm triggered after DiskWriteBytes is over or at 25 percent"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.asg-alarms.arn]
  dimensions = {
    AutoScalingGroupName = aws_eks_node_group.pokemon-frontend-nodes.node_group_name
  }
}
resource "aws_cloudwatch_metric_alarm" "ASG_StatusCheckFailed_Instance" {
  alarm_name          = "ASG_StatusCheckFailed_Instance"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "StatusCheckFailed_Instance"
  namespace           = "AWS/EC2"
  period              = "30"
  statistic           = "Average"
  threshold           = "25"
  alarm_description   = "Alarm triggered after StatusCheckFailed_Instance is over or at 25 percent"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.asg-alarms.arn]
  dimensions = {
    AutoScalingGroupName = aws_eks_node_group.pokemon-frontend-nodes.node_group_name
  }
}

resource "aws_cloudwatch_metric_alarm" "ASG_DiskWriteOps" {
  alarm_name          = "ASG_DiskWriteOps"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "DiskWriteOps"
  namespace           = "AWS/EC2"
  period              = "30"
  statistic           = "Average"
  threshold           = "25"
  alarm_description   = "Alarm triggered after DiskWriteOps is over or at 25 percent"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.asg-alarms.arn]
  dimensions = {
    AutoScalingGroupName = aws_eks_node_group.pokemon-frontend-nodes.node_group_name
  }
}

resource "aws_cloudwatch_metric_alarm" "ASG_NetworkOut" {
  alarm_name          = "ASG_NetworkOut"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "NetworkOut"
  namespace           = "AWS/EC2"
  period              = "30"
  statistic           = "Average"
  threshold           = "25"
  alarm_description   = "Alarm triggered after NetworkOut is over or at 25 percent"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.asg-alarms.arn]
  dimensions = {
    AutoScalingGroupName = aws_eks_node_group.pokemon-frontend-nodes.node_group_name
  }
}

resource "aws_cloudwatch_metric_alarm" "ASG_DiskReadBytes" {
  alarm_name          = "ASG_DiskReadBytes"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "DiskReadBytes"
  namespace           = "AWS/EC2"
  period              = "30"
  statistic           = "Average"
  threshold           = "20"
  alarm_description   = "Alarm triggered after DiskReadBytes is over or at 20 percent"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.asg-alarms.arn]
  dimensions = {
    AutoScalingGroupName = aws_eks_node_group.pokemon-frontend-nodes.node_group_name
  }
}

resource "aws_cloudwatch_metric_alarm" "ASG_NetworkPacketsIn" {
  alarm_name          = "ASG_NetworkPacketsIn"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "NetworkPacketsIn"
  namespace           = "AWS/EC2"
  period              = "30"
  statistic           = "Average"
  threshold           = "20"
  alarm_description   = "Alarm triggered after NetworkPacketsIn is over or at 20 percent"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.asg-alarms.arn]
  dimensions = {
    AutoScalingGroupName = aws_eks_node_group.pokemon-frontend-nodes.node_group_name
  }
}

resource "aws_cloudwatch_metric_alarm" "ASG_NetworkIn" {
  alarm_name          = "ASG_NetworkIn"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "NetworkIn"
  namespace           = "AWS/EC2"
  period              = "30"
  statistic           = "Average"
  threshold           = "20"
  alarm_description   = "Alarm triggered after NetworkIn is over or at 20 percent"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.asg-alarms.arn]
  dimensions = {
    AutoScalingGroupName = aws_eks_node_group.pokemon-frontend-nodes.node_group_name
  }
}
resource "aws_cloudwatch_metric_alarm" "ASG_CPUCreditBalance" {
  alarm_name          = "ASG_CPUCreditBalance"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUCreditBalance"
  namespace           = "AWS/EC2"
  period              = "30"
  statistic           = "Average"
  threshold           = "20"
  alarm_description   = "Alarm triggered after CPUCreditBalance is over or at 20 percent"
  actions_enabled     = true
  alarm_actions       = [aws_sns_topic.asg-alarms.arn]
  dimensions = {
    AutoScalingGroupName = aws_eks_node_group.pokemon-frontend-nodes.node_group_name
  }
}
// CloudWatch dashboard for Node Group metrics
resource "aws_cloudwatch_dashboard" "Node_group_metrics" {
  dashboard_name = "Node-group-Metrics"

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
              "AWS/EC2",
              "CPUUtilization",
              "AutoScalingGroupName",
              "${aws_eks_node_group.pokemon-frontend-nodes.node_group_name}"
            ]
          ]
          period = 30
          stat   = "Average"
          region = "us-east-1"
          title  = "CPU Utilization"
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
              "AWS/EC2",
              "DiskReadOps",
              "AutoScalingGroupName",
              "${aws_eks_node_group.pokemon-frontend-nodes.node_group_name}"
            ]
          ]
          period = 30
          stat   = "Average"
          region = "us-east-1"
          title  = "Disk Read Ops"
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
              "AWS/EC2",
              "NetworkPacketsOut",
              "AutoScalingGroupName",
              "${aws_eks_node_group.pokemon-frontend-nodes.node_group_name}"
            ]
          ]
          period = 30
          stat   = "Average"
          region = "us-east-1"
          title  = "Network Packets Out"
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
              "AWS/EC2",
              "DiskWriteBytes",
              "AutoScalingGroupName",
              "${aws_eks_node_group.pokemon-frontend-nodes.node_group_name}"
            ]
          ]
          period = 30
          stat   = "Average"
          region = "us-east-1"
          title  = "Disk Write Bytes"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 12
        width  = 6
        height = 6

        properties = {
          metrics = [
            [
              "AWS/EC2",
              "StatusCheckFailed_Instance",
              "AutoScalingGroupName",
              "${aws_eks_node_group.pokemon-frontend-nodes.node_group_name}"
            ]
          ]
          period = 30
          stat   = "Average"
          region = "us-east-1"
          title  = "Status Check Failed"
        }
      },
      {
        type   = "metric"
        x      = 6
        y      = 12
        width  = 6
        height = 6

        properties = {
          metrics = [
            [
              "AWS/EC2",
              "DiskWriteOps",
              "AutoScalingGroupName",
              "${aws_eks_node_group.pokemon-frontend-nodes.node_group_name}"
            ]
          ]
          period = 30
          stat   = "Average"
          region = "us-east-1"
          title  = "Disk Write Ops"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 18
        width  = 6
        height = 6

        properties = {
          metrics = [
            [
              "AWS/EC2",
              "NetworkOut",
              "AutoScalingGroupName",
              "${aws_eks_node_group.pokemon-frontend-nodes.node_group_name}"
            ]
          ]
          period = 30
          stat   = "Average"
          region = "us-east-1"
          title  = "Network Out"
        }
      },
      {
        type   = "metric"
        x      = 6
        y      = 18
        width  = 6
        height = 6

        properties = {
          metrics = [
            [
              "AWS/EC2",
              "DiskReadBytes",
              "AutoScalingGroupName",
              "${aws_eks_node_group.pokemon-frontend-nodes.node_group_name}"
            ]
          ]
          period = 30
          stat   = "Average"
          region = "us-east-1"
          title  = "Disk Read Bytes"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 24
        width  = 6
        height = 6

        properties = {
          metrics = [
            [
              "AWS/EC2",
              "NetworkPacketsIn",
              "AutoScalingGroupName",
              "${aws_eks_node_group.pokemon-frontend-nodes.node_group_name}"
            ]
          ]
          period = 30
          stat   = "Average"
          region = "us-east-1"
          title  = "Network Packets In"
        }
      },
      {
        type   = "metric"
        x      = 6
        y      = 24
        width  = 6
        height = 6

        properties = {
          metrics = [
            [
              "AWS/EC2",
              "NetworkIn",
              "AutoScalingGroupName",
              "${aws_eks_node_group.pokemon-frontend-nodes.node_group_name}"
            ]
          ]
          period = 30
          stat   = "Average"
          region = "us-east-1"
          title  = "Network In"
        }
      },
    ]
  })
}

// CloudWatch dashboard for Node Group metrics
resource "aws_cloudwatch_dashboard" "Node_group_line_metric" {
  dashboard_name = "Node_group_line_Metrics"

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
              "AWS/EC2",
              "CPUUtilization",
              "AutoScalingGroupName",
              "${aws_eks_node_group.pokemon-frontend-nodes.node_group_name}"
            ],
          ]
          period = 30
          stat   = "Average"
          region = "us-east-1"
          title  = "CPU Metrics Line"
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
              "AWS/EC2",
              "CPUCreditBalance",
              "AutoScalingGroupName",
              "${aws_eks_node_group.pokemon-frontend-nodes.node_group_name}"
            ],
          ]
          period = 30
          stat   = "Average"
          region = "us-east-1"
          title  = "CPU Metrics Line"
        }
      },
      // Add more line widgets for other metrics
    ]
  })
}
