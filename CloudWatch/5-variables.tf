# CloudWatch Events Rule
variable "cloudwatch_event_rule_name" {
  description = "Name of the CloudWatch Events rule"
  type        = string
}
variable "scheduled_expression" {
  type = string
  description = "sheduled expresion from module EventBridge"
  
}
variable "sns_topic_for_event_arn" {
  type = string
  description = "rds snapshot topic from module RDS"
  
}

###EKS cloudwatch / dashboards

variable "cloudwatch_dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  type        = string
}

variable "aws_region" {
  type = string
  description = "region where eks is deployed "
  
}

variable "aws_eks_asg_id" {
  description = "data value of the eks autoscaling group id"
  
}

variable "cloudwatch_alarm_name" {
  description = "Name of the CloudWatch alarm for eks-cluster"
  type        = string
}


variable "asg_cloudwatch_dashboard_name" {
  description = "Name of the CloudWatch dashboard for auto scaling groups"
  type        = string
}

variable "asg_cloudwatch_alarm_name" {
  description = "Name of the CloudWatch alarm for ASG CPU Utilization"
  type        = string
}

variable "node_line_graph_dashboard_name" {
  description = "Name of the CloudWatch dashboard for node line graph"
  type        = string
}
variable "eks_alarm_topic_arn" {
  description = "attach the eks sns topic arn"
  
}
variable "asg_alarm_topic_arn" {
  description = "attach the asg of eks sns topic arn"
  
}

