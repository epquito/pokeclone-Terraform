# AWS provider

variable "aws_region" {
    type = string
    description = "region to deploy resources"
    default = ""
}
variable "aws_profile" {
    type = string
    description = "AWS profile connecting to account with credentials"
    default = ""
}

# VPC
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "vpc_name" {
  description = "how the VPC will show up on the AWS console"
  type = string
  default = ""
}

# Private Subnet 1
variable "private_subnet1_cidr_block" {
  description = "CIDR block for private subnet 1"
  type        = string
  default     = ""
}
variable "private_subnet1_az" {
  description = "subnet availability zone"
  type = string
  default = ""
}

# Private Subnet 2
variable "private_subnet2_cidr_block" {
  description = "CIDR block for private subnet 2"
  type        = string
  default     = ""
}
variable "private_subnet2_az" {
  description = "subnet availability zone"
  type = string
  default = ""
}

# Public Subnet 1
variable "public_subnet1_cidr_block" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = ""
}
variable "public_subnet1_az" {
  description = "subnet availability zone"
  type = string
  default = ""
}

# Public Subnet 2
variable "public_subnet2_cidr_block" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = ""
}
variable "public_subnet2_az" {
  description = "subnet availability zone"
  type = string
  default = ""
}

# Internet Gateway
variable "internet_gateway_name" {
  description = "Name of the Internet Gateway"
  type        = string
  default     = ""
}

# Elastic IP
variable "nat_gateway_eip_name" {
  description = "Name of the Elastic IP for NAT Gateway"
  type        = string
  default     = ""
}

# NAT Gateway
variable "nat_gateway_name" {
  description = "Name of the NAT Gateway"
  type        = string
  default     = ""
}

# Route Tables
variable "private_route_table_name" {
  description = "Name of the private route table"
  type        = string
  default     = ""
}

variable "public_route_table_name" {
  description = "Name of the public route table"
  type        = string
  default     = ""
}

## Route table ACL
variable "public_pokemon_acl" {
  description = "public network ACL name"
  type = string
  default = ""
}

variable "private_pokemon_acl" {
  description = "private network ACL name"
  type = string
  default = ""
}

# Security Groups
variable "public_security_group_name" {
  description = "Name of the public security group"
  type        = string
  default     = ""
}

variable "operating_system_ip" {
  description = "personal IPv4"
  type = string
  default = ""
}

variable "private_security_group_name" {
  description = "Name of the private security group"
  type        = string
  default     = ""
}

# RDS
variable "db_subnet_group_name" {
  description = "Name of the RDS DB subnet group"
  type        = string
  default     = ""
}

variable "db_instance_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
  default     = ""
}

variable "db_name" {
  description = "Name of the RDS database"
  type        = string
  default     = ""
}

variable "db_username" {
  description = "Username for the RDS instance"
  type        = string
  default     = ""
}

variable "db_password" {
  description = "Password for the RDS instance"
  type        = string
  default     = ""
}

# EKS
variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = ""
}

variable "eks_cluster_role_name" {
  description = "Name of the IAM role for EKS cluster"
  type        = string
  default     = ""
}

variable "eks_cluster_log_group_name" {
  description = "Name of the CloudWatch Log Group for EKS cluster"
  type        = string
  default     = ""
}

variable "eks_cluster_version" {
  description = "EKS cluster/platform version"
  type = string
  default = ""
}

variable "cluster_ipv4_range" {
  description = "Cluster IPv4 range CIDR block"
  type = string
  default = ""
}

variable "eks_node_group_name" {
  description = "Name of the EKS node group"
  type        = string
  default     = ""
}

variable "eks_node_group_instance_type" {
  description = "Instance type for EKS node group"
  type        = string
  default     = ""
}

variable "eks_node_group_desired_size" {
  description = "Desired number of instances in EKS node group"
  type        = number
  default     = 1
}

variable "eks_node_group_max_size" {
  description = "Maximum number of instances in EKS node group"
  type        = number
  default     = 2
}

variable "eks_node_group_min_size" {
  description = "Minimum number of instances in EKS node group"
  type        = number
  default     = 1
}

variable "eks_node_group_key_name" {
  description = "SSH key name for EKS node group instances"
  type        = string
  default     = ""
}

variable "node_group_ami_type" {
  description = "Depending on the EKS cluster versions the AMI type will vary"
  type = string
  default = ""
}

variable "eks_oidc_role_name" {
  description = "Name of the IAM role for EKS OIDC"
  type        = string
  default     = ""
}

variable "eks_oidc_policy_name" {
  description = "Name of the IAM policy for EKS OIDC"
  type        = string
  default     = ""
}

variable "eks_cluster_autoscaler_role_name" {
  description = "Name of the IAM role for EKS cluster autoscaler"
  type        = string
  default     = ""
}

variable "eks_cluster_autoscaler_policy_name" {
  description = "Name of the IAM policy for EKS cluster autoscaler"
  type        = string
  default     = ""
}

variable "eks_csi_driver_role_name" {
  description = "Name of the IAM role for EBS CSI driver"
  type        = string
  default     = ""
}

variable "eks_ebs_csi_add_on_version" {
  description = "Depending on the EKS cluster version the compatibility of the Add-on version will vary"
  type = string
  default = ""
}

# SNS

# SNS Topic
variable "sns_topic_name_eventbridge" {
  description = "Name of the SNS topic for RDS event snapshot"
  type        = string
  default     = ""
}

variable "sns_topic_name_eks" {
  description = "Name of the SNS topic for EKS cluster alarms"
  type        = string
  default     = ""
}

variable "asg_sns_topic_name" {
  description = "Name of the SNS topic for auto-scaling groups in EKS"
  type        = string
  default     = ""
}

# SNS subscriptions 
variable "sns_topic_email_eventbridge" {
  description = "Email address for SNS topic subscription"
  type        = string
  default     = ""
}

variable "sns_subscription_email_EKS" {
  description = "Email address for SNS topic subscription"
  type        = string
  default     = ""
}

variable "asg_sns_subscription_email" {
  description = "Email address for SNS topic subscription"
  type        = string
  default     = ""
}

# EventBridge
variable "iam_role_name" {
  description = "Name of the IAM role for EventBridge"
  type        = string
  default     = ""
}

# CloudWatch Events Rule
variable "cloudwatch_event_rule_name" {
  description = "Name of the CloudWatch Events rule"
  type        = string
  default     = ""
}

# EKS CloudWatch / Dashboards
variable "cloudwatch_dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  type        = string
  default     = ""
}

variable "cloudwatch_alarm_name" {
  description = "Name of the CloudWatch alarm for EKS cluster"
  type        = string
  default     = ""
}

variable "asg_cloudwatch_dashboard_name" {
  description = "Name of the CloudWatch dashboard for auto-scaling groups"
  type        = string
  default     = ""
}

variable "asg_cloudwatch_alarm_name" {
  description = "Name of the CloudWatch alarm for ASG CPU Utilization"
  type        = string
  default     = ""
}

variable "node_line_graph_dashboard_name" {
  description = "Name of the CloudWatch dashboard for node line graph"
  type        = string
  default     = ""
}
