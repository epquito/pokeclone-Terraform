# Pokemon Terraform Configuration for Amazon EKS

## Introduction
This project provides a comprehensive Terraform configuration designed for deploying a highly available and scalable Amazon Elastic Kubernetes Service (EKS) environment. It includes setups for a VPC, subnets, Internet Gateway (IGW), NAT Gateway, route tables, and an Amazon RDS instance, ensuring a robust infrastructure for containerized applications.

## Project Structure

- vpc.tf: Sets up the AWS VPC.
- subnets.tf: Defines public and private subnets.
- igw.tf: Creates the Internet Gateway.
- nat_gateway.tf: Provisions the NAT Gateway.
- route_tables.tf: Configures routing for the VPC.
- eks_cluster.tf: Deploys the EKS cluster.
- rds.tf: Provisions an RDS instance.
  
## Table of Contents

- [Steps for VPC](#steps-for-vpc)
- [Steps for EKS](#steps-for-eks)

## Steps for VPC

### Step 1: Provider Configuration
Create a file named ```provider.tf``` and input the following configuration to specify the AWS provider and required version.
```
provider "aws" {
  region  = "us-east-1"
  profile = "east1-user"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}
```

### Step 2: VPC Creation
Create a file named ```vpc.tf``` and add the following code to define a VPC named pokemon with a CIDR block of 10.0.0.0/24.

```
resource "aws_vpc" "pokemon" {
  cidr_block           = "10.0.0.0/24"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "pokemon"
  }
}

### Step 3: Internet Gateway
Create a file named igw.tf and configure an Internet Gateway for your VPC.
```resource "aws_internet_gateway" "pokemon-igw" {
  vpc_id = aws_vpc.pokemon.id
  tags = {
    Name = "pokemon-igw"
  }
}
```

### Step 4: NAT Gateway and EIP
Create a file named nat-gw.tf. Define an Elastic IP (EIP) and a NAT Gateway to allow outbound internet access for instances in private subnets.
```resource "aws_eip" "pokemon-nat" {
  vpc = true
  tags = {
    Name = "pokemon-nat"
  }
}

resource "aws_nat_gateway" "pokemon-nat-gw" {
  allocation_id = aws_eip.pokemon-nat.id
  subnet_id     = aws_subnet.public-subnet-1.id # This will be defined in your subnet configuration
  tags = {
    Name = "pokemon-nat-gw"
  }
  depends_on = [aws_internet_gateway.pokemon-igw]
}
```

### Step 5: Security Groups
Create a file named security.tf. This file defines two security groups: one for public access and another for your RDS PostgreSQL database.

- Public Security Group allows inbound traffic on ports 22 (SSH), 80 (HTTP), 8000, and 5432 (PostgreSQL), along with unrestricted outbound traffic.
- RDS PostgreSQL Security Group allows inbound traffic on port 5432 (PostgreSQL) and unrestricted outbound traffic.
```resource "aws_security_group" "public_sg" {
    name        = "public-sg"
    description = "Public Security Group"
    vpc_id      = aws_vpc.pokemon.id  # Replace with your VPC ID

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 8000
        to_port     = 8000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "public-sg"
    }
}

resource "aws_security_group" "rds_postgres_sg" {
    name        = "rds-postgres-sg"
    description = "Security Group for RDS PostgreSQL"
    vpc_id      = aws_vpc.pokemon.id  # Replace with your VPC ID

    ingress {
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "rds-postgres-sg"
    }
}
```
  
### Step 6: RDS Database
Create a file named rds.tf. This file creates an RDS instance for a PostgreSQL database within the VPC.
```resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "db-subnet-group"
  subnet_ids = [
    aws_subnet.public-subnet-1.id,
    aws_subnet.public-subnet-2.id,
  ]
}

resource "aws_db_instance" "pokemonDatabase" {
  allocated_storage      = 20
  identifier             = "pokeclone-db"
  db_name                = "pokeclone_db"
  engine                 = "postgres"
  engine_version         = "12.17"
  instance_class         = "db.t2.micro"
  username               = "postgres"
  password               = "postgres"
  parameter_group_name   = "default.postgres12"
  publicly_accessible    = true
  skip_final_snapshot    = true
  deletion_protection    = false
  vpc_security_group_ids = [aws_security_group.rds_postgres_sg.id]

  db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.name
}
```

### Step 7: Outputs
Create a file named outputs.tf. This file defines outputs for various resources such as VPC ID, subnet IDs, and more for easy reference.
```output "vpc_id" {
    value = aws_vpc.pokemon.id
}
output "subnet_ids" {
    value = [
        aws_subnet.public-subnet-1.id,
        aws_subnet.public-subnet-2.id,
        aws_subnet.private-subnet-1.id,
        aws_subnet.private-subnet-2.id,

    ]
  
}

output "public_subnet_ids" {
    value = [
        aws_subnet.public-subnet-1.id,
        aws_subnet.public-subnet-2.id,
    ]
}

output "private_subnet_ids" {
    value = [
        aws_subnet.private-subnet-1.id,
        aws_subnet.private-subnet-2.id,
    ]
}

output "internet_gateway_id" {
    value = aws_internet_gateway.pokemon-igw.id
}

output "nat_gateway_id" {
    value = aws_nat_gateway.pokemon-nat-gw.id
}

output "private_route_table_id" {
    value = aws_route_table.private-route-pokemon.id
}

output "public_route_table_id" {
    value = aws_route_table.public-route-pokemon.id
}

output "public_security_group_id" {
    value = aws_security_group.public_sg.id
}

output "rds_postgres_security_group_id" {
    value = aws_security_group.rds_postgres_sg.id
}

output "db_subnet_group_name" {
    value = aws_db_subnet_group.db-subnet-group.name
}

output "db_instance_endpoint" {
    value = aws_db_instance.pokemonDatabase.endpoint
}
```

## Steps for EKS

### Step 1: Provider Configuration
Sets up the Terraform provider for AWS. It specifies the AWS region and the profile to use for authentication.
```provider "aws" {
  region = "us-east-1"
  profile = "east1-user"
}
```

Declares the required Terraform provider(s) and their versions. Here, it specifies the AWS provider.
```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}
```

Uses a custom module for VPC setup located at a specified path. This module is responsible for creating the VPC where the EKS cluster will reside.
```
module "VPC" {
  source = "/path/to/VPC/module"
}
```

### Step 2: IAM Roles and Policies for EKS
Defines IAM roles and policies needed for the EKS cluster and worker nodes to operate. This includes roles for the EKS control plane, node groups, OIDC, autoscaler, and EBS CSI driver, along with necessary policy attachments.

- **aws_iam_role** resources define roles with specific permissions.
- **aws_iam_policy** resources define the actual permissions in JSON format.
- **aws_iam_role_policy_attachment** resources attach policies to roles.

```resource "aws_iam_role" "pokemon-demo" {
  name = "pokemon-eks-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
resource "aws_iam_policy" "eks_control_plane_logs" {
  name   = "eks-control-plane-logs-policy"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_control_plane_logs" {
  policy_arn = aws_iam_policy.eks_control_plane_logs.arn
  role       = aws_iam_role.pokemon-demo.name
}

resource "aws_iam_role_policy_attachment" "pokemon-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.pokemon-demo.name
}
```
Creates an EKS cluster named **pokemon-cluster**, specifying its configuration, including the VPC setup through the module and the IAM role for the control plane.
```
resource "aws_eks_cluster" "pokemon-cluster" {
  name     = "pokemon-cluster"
  role_arn = aws_iam_role.pokemon-demo.arn

  vpc_config {
    endpoint_private_access = false 
    endpoint_public_access = true
    subnet_ids = module.VPC.subnet_ids
  }
  enabled_cluster_log_types = ["api", "authenticator", "audit", "scheduler", "controllerManager"]
  depends_on = [aws_iam_role_policy_attachment.pokemon-AmazonEKSClusterPolicy]
}
resource "aws_cloudwatch_log_group" "eks_control_plane_logs" {
  name              = "/aws/eks/pokemon-cluster/control-plane-logs"
  retention_in_days = 7
}
```
### Step 3: Worker Nodes
Sets up worker node groups for the EKS cluster, defining their configurations such as instance types, scaling options, and IAM roles.

```# IAM Role for EKS Nodes
resource "aws_iam_role" "pokemon-eks-node-group-nodes" {
  name = "pokemon-eks-node-group-nodes"

  # Assume role policy allowing EC2 instances to assume this role
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

# IAM Role Policy Attachments
resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  # Attach AmazonEKSWorkerNodePolicy to the IAM role
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.pokemon-eks-node-group-nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  # Attach AmazonEKS_CNI_Policy to the IAM role
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.pokemon-eks-node-group-nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  # Attach AmazonEC2ContainerRegistryReadOnly to the IAM role
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.pokemon-eks-node-group-nodes.name
}

# EKS Node Group for Frontend in Public Subnets
resource "aws_eks_node_group" "pokemon-frontend-nodes" {
  cluster_name    = aws_eks_cluster.pokemon-cluster.name
  node_group_name = "pokemon-frontend-nodes"
  node_role_arn   = aws_iam_role.pokemon-eks-node-group-nodes.arn

  subnet_ids = module.VPC.public_subnet_ids
  capacity_type  = "ON_DEMAND"
  instance_types = ["t2.small"]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "frontend"
  }

  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
  remote_access {
    ec2_ssh_key = "devops-ew"
    source_security_group_ids = [module.VPC.public_security_group_id]
  }
}
```

### Step 4: OIDC Provider
Configures an OIDC provider for the cluster, allowing for IAM roles to be assumed by Kubernetes service accounts.

```data "aws_iam_policy_document" "pokemon_oidc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:default:pokemon-test"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "pokemon_oidc" {
  assume_role_policy = data.aws_iam_policy_document.pokemon_oidc_assume_role_policy.json
  name               = "pokemon-oidc"
}

resource "aws_iam_policy" "pokemon-policy" {
  name = "pokemon-policy"

  policy = jsonencode({
    Statement = [{
      Action   = ["s3:ListAllMyBuckets", "s3:GetBucketLocation"]
      Effect   = "Allow"
      Resource = "arn:aws:s3:::*"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "pokemon_attach" {
  role       = aws_iam_role.pokemon_oidc.name
  policy_arn = aws_iam_policy.pokemon-policy.arn
}

output "pokemon_policy_arn" {
  value = aws_iam_role.pokemon_oidc.arn
}
# Data block for TLS Certificate
data "tls_certificate" "eks" {
  url = aws_eks_cluster.pokemon-cluster.identity[0].oidc[0].issuer
}

# IAM OpenID Connect Provider
resource "aws_iam_openid_connect_provider" "eks" {
  # Update with the correct client ID(s) for your OIDC provider
  client_id_list  = ["sts.amazonaws.com"]

  # Update with the correct TLS certificate thumbprint for your OIDC provider
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]

  # Update with the correct OIDC issuer URL for your EKS cluster
  url             = aws_eks_cluster.pokemon-cluster.identity[0].oidc[0].issuer
}
```

### Step 5: Cluster Autoscaler

Sets up the IAM role and policy for the cluster autoscaler, allowing it to manage the scaling of worker nodes based on demand.

```data "aws_iam_policy_document" "pokemon_cluster_autoscaler_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:pokemon-cluster-autoscaler"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "pokemon_cluster_autoscaler" {
  assume_role_policy = data.aws_iam_policy_document.pokemon_cluster_autoscaler_assume_role_policy.json
  name               = "pokemon-cluster-autoscaler"
}

resource "aws_iam_policy" "pokemon_cluster_autoscaler" {
  name = "pokemon-cluster-autoscaler"

  policy = jsonencode({
    Statement = [{
      Action   = [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:DescribeTags",
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup",
        "ec2:DescribeLaunchTemplateVersions"
      ]
      Effect   = "Allow"
      Resource = "*"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "pokemon_cluster_autoscaler_attach" {
  role       = aws_iam_role.pokemon_cluster_autoscaler.name
  policy_arn = aws_iam_policy.pokemon_cluster_autoscaler.arn
}

output "pokemon_cluster_autoscaler_arn" {
  value = aws_iam_role.pokemon_cluster_autoscaler.arn
}
```

### Step 6: EBS CSI Driver

Configures the IAM role and policy for the EBS CSI driver, enabling Kubernetes pods to use AWS EBS volumes for storage.

```data "aws_iam_policy_document" "pokemon-ebs-csi" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "eks_ebs_csi_driver" {
  assume_role_policy = data.aws_iam_policy_document.pokemon-ebs-csi.json
  name               = "eks-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "amazon_ebs_csi_driver" {
  role       = aws_iam_role.eks_ebs_csi_driver.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

resource "aws_eks_addon" "pokemon_csi_driver" {
    cluster_name             = aws_eks_cluster.pokemon-cluster.name
    addon_name               = "aws-ebs-csi-driver"
    addon_version            = "v1.28.0-eksbuild.1"
    service_account_role_arn = aws_iam_role.eks_ebs_csi_driver.arn
  }```

### Step 7: Cloud Watch

Monitor an Amazon EKS (Elastic Kubernetes Service) cluster using AWS CloudWatch and SNS (Simple Notification Service). The aim is to ensure the health, performance, and security of the EKS cluster by providing real-time alerts and a dashboard for ongoing monitoring.

```// Create SNS topic for eks-cluster-alarms
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
```

### Step 8: EKS node cloudwatch:
create a comprehensive monitoring and notification system for Amazon Elastic Kubernetes Service (EKS) node groups, particularly focusing on auto scaling groups (ASGs).

```// Create SNS topic for auto scaling groups in eks
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
```

### Step 9: Outputs
The ```outputs.tf``` snippet for Terraform defines an output named **eks** that provides a command for configuring **kubectl** to interact with an AWS Elastic Kubernetes Service (EKS) cluster named pokemon-cluster in the **us-east-1** region. When you apply your Terraform configuration, this output will display a command to update your local **kubeconfig** file, enabling kubectl to communicate with and manage your EKS cluster. This simplifies the process of setting up kubectl for cluster management by providing a ready-to-use command post-deployment.

```output "eks" {
  value = <<EOF
###################################### KUBECONFIG ###########################################

        aws eks --region us-east-1 update-kubeconfig --name pokemon-cluster
EOF
}
```

## Instructions

### 1. Initialize Terraform
Run ```terraform init``` to initialize Terraform, downloading necessary providers and modules.

### 2. Plan the Deployment

Execute ```terraform plan``` to review the changes Terraform will perform.

### 3. Apply the Configuration

Use ```terraform apply``` to apply the configuration. Confirm the action when prompted.

### 4. Access the Cluster

After deployment, configure ```kubectl``` with the EKS cluster by running ```aws eks --region us-east-1 update-kubeconfig --name pokemon-cluster```.



## Conclusion
This setup will result in a fully functional AWS EKS cluster with configured IAM roles, VPC, worker nodes, OIDC for service accounts, autoscaling, and EBS CSI for persistent storage. Each step ensures the necessary permissions and configurations are in place for a secure and scalable Kubernetes environment on AWS.
