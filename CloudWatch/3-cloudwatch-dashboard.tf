resource "aws_cloudwatch_dashboard" "EKS-CLuster-Terraform-Pokeclone" {
  dashboard_name = var.cloudwatch_dashboard_name

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 24
        height = 9

        properties = {
          sparkline = true
          view      = "singleValue"
          metrics   = [
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
            ],
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
            ],
            [
              "AWS/Logs",       # Namespace
              "IncomingBytes",       # Metric name
              "LogGroupName",        # Dimension name
              "/aws/eks/pokemon-cluster/cluster",   
            ],
            [
              "AWS/Logs",       # Namespace
              "IncomingLogEvents",       # Metric name
              "LogGroupName",        # Dimension name
              "/aws/eks/pokemon-cluster/cluster",   
            ]
          ]
          region = "${var.aws_region}"
        }
      },
    ]
  })
}



resource "aws_cloudwatch_dashboard" "Node-group-dashboard" {
  dashboard_name = var.asg_cloudwatch_dashboard_name
  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 24
        height = 9

        properties = {
          sparkline = true
          view      = "singleValue"
          metrics   = [
            [
              "AWS/EC2",
              "CPUUtilization",
              "AutoScalingGroupName",
              "${var.aws_eks_asg_id}"
            ],
            [
              "AWS/EC2",
              "DiskReadOps",
              "AutoScalingGroupName",
              "${var.aws_eks_asg_id}"            ],
            [
              "AWS/EC2",
              "NetworkPacketsOut",
              "AutoScalingGroupName",
              "${var.aws_eks_asg_id}"            ],
            [
              "AWS/EC2",
              "DiskWriteBytes",
              "AutoScalingGroupName",
              "${var.aws_eks_asg_id}"            ],
            [
              "AWS/EC2",
              "StatusCheckFailed_Instance",
              "AutoScalingGroupName",
              "${var.aws_eks_asg_id}"            ],
            [
              "AWS/EC2",
              "DiskWriteOps",
              "AutoScalingGroupName",
              "${var.aws_eks_asg_id}"            ],
            [
              "AWS/EC2",
              "NetworkOut",
              "AutoScalingGroupName",
              "${var.aws_eks_asg_id}"            ],
            [
              "AWS/EC2",
              "DiskReadBytes",
              "AutoScalingGroupName",
              "${var.aws_eks_asg_id}"            ],
            [
              "AWS/EC2",
              "NetworkPacketsIn",
              "AutoScalingGroupName",
              "${var.aws_eks_asg_id}"            ],
            [
              "AWS/EC2",
              "NetworkIn",
              "AutoScalingGroupName",
              "${var.aws_eks_asg_id}"            ]
          ]
          region = "${var.aws_region}"
        }
      }
    ]
  })
}

resource "aws_cloudwatch_dashboard" "Node-line-graph" {
  dashboard_name = var.node_line_graph_dashboard_name

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 4

        properties = {
          title    = "CPU Utilization"
          sparkline = true
          metrics   = [
            [
              "AWS/EC2",
              "CPUUtilization",
              "AutoScalingGroupName",
              "${var.aws_eks_asg_id}"             ]
          ]
          region = "${var.aws_region}"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 5
        width  = 12
        height = 4

        properties = {
          title    = "CPU Credit Balance"
          sparkline = true
          metrics   = [
            [
              "AWS/EC2",
              "CPUCreditBalance",
              "AutoScalingGroupName",
              "${var.aws_eks_asg_id}"             ]
          ]
          region = "${var.aws_region}"
        }
      }
    ]
  })
}

