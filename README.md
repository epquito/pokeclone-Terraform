# Pokemon Terraform Configuration for Amazon EKS
The diagram illustrates a comprehensive AWS infrastructure deployment tailored for full-scale production. However, our current focus is solely on the public-facing aspect of the deployment. Nonetheless, it's worth noting that the groundwork has been established to seamlessly transition into a complete public/private EKS deployment when needed.

  ![Alt Text](https://github.com/epquito/pokeclone-Terraform/blob/master/AWS-Terraform-Architecture-Structure.jpeg)

## Introduction
This project provides a comprehensive Terraform configuration designed for deploying a highly available and scalable Amazon Elastic Kubernetes Service (EKS) environment. It includes setups for a VPC, subnets, Internet Gateway (IGW), NAT Gateway, route tables, and an Amazon RDS instance, ensuring a robust infrastructure for containerized applications.

## Table of Contents

- [Steps for VPC](#steps-for-vpc)
- [Steps for EKS](#steps-for-eks)

## Change the variables default attribute to the value you want or need
## Variables tf for VPC:
```
variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = ""  # Change this to your desired AWS region
}

variable "profile" {
  description = "AWS CLI profile name to be used by Terraform"
  type        = string
  default     = ""  # Change this to your AWS CLI profile
}

# VPC
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}

# Subnets
variable "private_subnet1_cidr_block" {
  description = "CIDR block for private subnet 1"
  type        = string
  default     = ""
}

variable "private_subnet2_cidr_block" {
  description = "CIDR block for private subnet 2"
  type        = string
  default     = ""
}

variable "public_subnet1_cidr_block" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = ""
}

variable "public_subnet2_cidr_block" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = ""
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

# Security Groups
variable "public_security_group_name" {
  description = "Name of the public security group"
  type        = string
  default     = ""
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

# SNS Topic
variable "sns_topic_name" {
  description = "Name of the SNS Topic"
  type        = string
  default     = ""
}

variable "sns_topic_email" {
  description = "Email address for SNS topic subscription"
  type        = string
  default     = ""
}

# IAM Role for EventBridge
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

```
## Variables tf for EKS:
```
variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = ""  # Update with your desired default region
}
variable "aws_VPC_path" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = ""  
}

variable "aws_profile" {
  description = "The AWS CLI named profile to use for authentication"
  type        = string
  default     = ""  # Update with your AWS CLI profile
}

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
  default     = 
}

variable "eks_node_group_max_size" {
  description = "Maximum number of instances in EKS node group"
  type        = number
  default     = 
}

variable "eks_node_group_min_size" {
  description = "Minimum number of instances in EKS node group"
  type        = number
  default     = 
}

variable "eks_node_group_key_name" {
  description = "SSH key name for EKS node group instances"
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

variable "sns_topic_name" {
  description = "Name of the SNS topic for eks-cluster-alarms"
  type        = string
  default     = ""
}

variable "sns_subscription_email" {
  description = "Email address for SNS topic subscription"
  type        = string
  default     = ""
}

variable "cloudwatch_dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  type        = string
  default     = ""
}

variable "cloudwatch_alarm_name" {
  description = "Name of the CloudWatch alarm for eks-cluster"
  type        = string
  default     = ""
}
// Variables
variable "asg_sns_topic_name" {
  description = "Name of the SNS topic for auto scaling groups in eks"
  type        = string
  default     = ""
}

variable "asg_sns_subscription_email" {
  description = "Email address for SNS topic subscription for auto scaling groups"
  type        = string
  default     = ""
}

variable "asg_cloudwatch_dashboard_name" {
  description = "Name of the CloudWatch dashboard for auto scaling groups"
  type        = string
  default     = ""
}

variable "asg_cloudwatch_alarm_name" {
  description = "Name of the CloudWatch alarm for ASG CPU Utilization"
  type        = string
  default     = ""
}

variable "asg_cloudwatch_alarm_threshold" {
  description = "Threshold value for the CloudWatch alarm for ASG CPU Utilization"
  type        = number
  default     = 
}

variable "node_line_graph_dashboard_name" {
  description = "Name of the CloudWatch dashboard for node line graph"
  type        = string
  default     = ""
}

```

## Steps for VPC

### Step 1: Provider Configuration
Create a file named ```provider.tf``` and input the following configuration to specify the AWS provider and required version.
```
provider "aws" {
    region = var.region
    profile = var.profile
  
}
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
    }
  }
}
```

### Step 2: VPC Creation
Create a file named ```vpc.tf``` and add the following code to define a VPC named pokemon with a CIDR block of 10.0.0.0/24.

```
resource "aws_vpc" "pokemon" {

    cidr_block = var.vpc_cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      Name = "pokemon"
    }
}
```

### Step 3: Internet Gateway
Create a file named igw.tf and configure an Internet Gateway for your VPC.
```resource "aws_internet_gateway" "pokemon-igw" {
    vpc_id = aws_vpc.pokemon.id
    tags = {
      Name = var.internet_gateway_name
    }
}

```

### Step 4: NAT Gateway and EIP
Create a file named nat-gw.tf. Define an Elastic IP (EIP) and a NAT Gateway to allow outbound internet access for instances in private subnets.
```resource "aws_eip" "pokemon-nat" {
    vpc = true
    tags = {
      Name = var.nat_gateway_eip_name
    }
  
}
resource "aws_nat_gateway" "pokemon-nat-gw" {
  allocation_id = aws_eip.pokemon-nat.id 
  subnet_id     = aws_subnet.public-subnet-1.id  # Corrected subnet reference
  tags = {
    Name = var.nat_gateway_name
  }
  depends_on = [aws_internet_gateway.pokemon-igw]  # Corrected dependency reference
}

```
### Step 5 Creating Subnets 
```
resource "aws_subnet" "private-subnet-1" {
  vpc_id = aws_vpc.pokemon.id 
  cidr_block = var.private_subnet1_cidr_block
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "private-subnet-1"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/pokemon-cluster" = "owned"

  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id = aws_vpc.pokemon.id 
  cidr_block = var.private_subnet2_cidr_block
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "private-subnet-2"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/pokemon-cluster" = "owned"

  }
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id = aws_vpc.pokemon.id 
  cidr_block = var.public_subnet1_cidr_block
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "public-subnet-1"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/pokemon-cluster" = "owned"

  }
}
resource "aws_subnet" "public-subnet-2" {
  vpc_id = aws_vpc.pokemon.id 
  cidr_block = var.public_subnet2_cidr_block
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "public-subnet-2"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/pokemon-cluster" = "owned"

  }
}


```
### Step 6 : Route tables

```
resource "aws_route_table" "private-route-pokemon" {
  vpc_id = aws_vpc.pokemon.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.pokemon-nat-gw.id
  }

  tags = {
    Name = var.private_route_table_name
  }
}

resource "aws_route_table" "public-route-pokemon" {
  vpc_id = aws_vpc.pokemon.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pokemon-igw.id
  }

  tags = {
    Name = var.public_route_table_name
  }
}

resource "aws_route_table_association" "private-subnet-1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route-pokemon.id
}

resource "aws_route_table_association" "private-subnet-2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-route-pokemon.id
}

resource "aws_route_table_association" "public-subnet-1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route-pokemon.id
}

resource "aws_route_table_association" "public-subnet-2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-route-pokemon.id
}

```
### Step 7: Security Groups
Create a file named security.tf. This file defines two security groups: one for public access and another for your RDS PostgreSQL database.

- Public Security Group allows inbound traffic on ports 22 (SSH), 80 (HTTP), 8000, and 5432 (PostgreSQL), along with unrestricted outbound traffic.
- RDS PostgreSQL Security Group allows inbound traffic on port 5432 (PostgreSQL) and unrestricted outbound traffic.
```resource "aws_security_group" "public_sg" {
    name        = var.public_security_group_name
    description = "Public Security Group"
    vpc_id      = aws_vpc.pokemon.id  # Replace with your VPC ID

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = var.public_security_group_name
    }
}

resource "aws_security_group" "private_sg" {
    name        = var.private_security_group_name
    description = "Security Group for private_sg"
    vpc_id      = aws_vpc.pokemon.id  # Replace with your VPC ID

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        security_groups = [ aws_security_group.public_sg.id ]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = var.private_security_group_name
    }
}
```
  
### Step 8: RDS Database
Create a file named rds.tf. This file creates an RDS instance for a PostgreSQL database within the VPC.
```# Create a DB subnet group
resource "aws_db_subnet_group" "db-subnet-group" {
  name       = var.db_subnet_group_name
  subnet_ids = [
    aws_subnet.public-subnet-1.id,
    aws_subnet.public-subnet-2.id,
  ]
}

# Create an RDS instance
resource "aws_db_instance" "pokemonDatabase" {
  allocated_storage      = 20
  identifier             = var.db_instance_identifier
  db_name                = var.db_name
  engine                 = "postgres"
  engine_version         = "12.17"
  instance_class         = "db.t2.micro"
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.postgres12"
  publicly_accessible    = true
  skip_final_snapshot    = true
  deletion_protection    = false
  vpc_security_group_ids = [aws_security_group.public_sg.id]

  db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.name
  iam_database_authentication_enabled = true

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  backup_retention_period = 1
}
```
### Step 9: EventBridge with SNS topic/subscription

```
# Create an SNS Topic
resource "aws_sns_topic" "db_snapshot_event_topic" {
  name = var.sns_topic_name
}

# Subscribe edwinquito45@gmail.com to the SNS Topic
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.db_snapshot_event_topic.arn
  protocol  = "email"
  endpoint  = var.sns_topic_email
}
# Create IAM Role for EventBridge
resource "aws_iam_role" "eventbridge_role" {
  name = var.iam_role_name
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "scheduler.amazonaws.com",
      },
    }],
  })
}

# Attach policies to the IAM Role
resource "aws_iam_role_policy_attachment" "eventbridge_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"  # Adjust based on your specific needs
  role       = aws_iam_role.eventbridge_role.name
}

resource "aws_scheduler_schedule" "rds_snapshot_schedule" {
  name = "rds_snapshot_schedule"
  flexible_time_window {
    mode = "FLEXIBLE"
    maximum_window_in_minutes = 5
  }
  

  schedule_expression = "cron(0/10 * * * ? *)"


  target {
    arn = "arn:aws:scheduler:::aws-sdk:rds:createDBSnapshot"
    role_arn = aws_iam_role.eventbridge_role.arn

    input = jsonencode({
      DbInstanceIdentifier = var.db_instance_identifier,  # Replace with the correct DB instance identifier
      DbSnapshotIdentifier = "pokeclone-db-snapshot-schedule"
    })
  }

  depends_on = [aws_db_instance.pokemonDatabase]
}

# Create CloudWatch Events rules
resource "aws_cloudwatch_event_rule" "rds_snapshot_rule" {
  name        = var.cloudwatch_event_rule_name
  description = "Rule to trigger RDS snapshots"
  schedule_expression = aws_scheduler_schedule.rds_snapshot_schedule.schedule_expression
}

# Add a target to the CloudWatch Events rule (SNS topic)
resource "aws_cloudwatch_event_target" "rds_snapshot_target" {
  rule      = aws_cloudwatch_event_rule.rds_snapshot_rule.name
  arn       = aws_sns_topic.db_snapshot_event_topic.arn
}

resource "aws_sns_topic_policy" "db_snapshot_event_topic_policy" {
  arn = aws_sns_topic.db_snapshot_event_topic.arn

  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "CloudWatchEventsToSNSPolicy",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "events.amazonaws.com",
        },
        Action = "sns:Publish",
        Resource = "*",
      },
    ],
  })
}
```

### Step 10: Outputs
Create a file named outputs.tf. This file defines outputs for various resources such as VPC ID, subnet IDs, and more for easy reference between modules or different directories of .tf files.
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
## Steps for EKS:

### Step 1: Cluster roles/Creation
```
resource "aws_iam_role" "pokemon-demo" {
  name = var.eks_cluster_role_name

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

resource "aws_eks_cluster" "pokemon-cluster" {
  name     = var.eks_cluster_name
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
  name              = var.eks_cluster_log_group_name
  retention_in_days = 7
}

```

### Step 2: IAM roles for Worker nodes and creation
```
# IAM Role for EKS Nodes
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
  node_group_name = var.eks_node_group_name
  node_role_arn   = aws_iam_role.pokemon-eks-node-group-nodes.arn

  subnet_ids = module.VPC.public_subnet_ids
  capacity_type  = "ON_DEMAND"
  instance_types = [var.eks_node_group_instance_type]

  scaling_config {
    desired_size = var.eks_node_group_desired_size
    max_size     = var.eks_node_group_max_size
    min_size     = var.eks_node_group_min_size
  }

  update_config {
    max_unavailable = 1
  }
  tags = {
    Name = var.eks_node_group_name
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
    ec2_ssh_key = var.eks_node_group_key_name
    source_security_group_ids = [module.VPC.public_security_group_id]
  }
}
# resource "aws_iam_role_policy_attachment" "nodes-AmazonSSMManagedInstanceCore" {
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMManagedInstanceCore"
#   role       = aws_iam_role.pokemon-eks-node-group-nodes.name
# }

# # EKS Node Group for Frontend in Public Subnets
# resource "aws_eks_node_group" "pokemon-backend-nodes" {
#   cluster_name    = aws_eks_cluster.pokemon-cluster.name
#   node_group_name = "pokemon-backend-nodes"
#   node_role_arn   = aws_iam_role.pokemon-eks-node-group-nodes.arn

#   subnet_ids = module.VPC.private_subnet_ids
#   capacity_type  = "ON_DEMAND"
#  instance_types = [var.eks_node_group_instance_type]

#  scaling_config {
#    desired_size = var.eks_node_group_desired_size
#    max_size     = var.eks_node_group_max_size
#    min_size     = var.eks_node_group_min_size
# }

#   update_config {
#     max_unavailable = 1
#   }
#   tags = {
#     Name = "pokemon-backend-nodes"
#   }
#   labels = {
#     role = "backend"
#   }



#   depends_on = [
#     aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
#     aws_iam_role_policy_attachment.nodes-AmazonSSMManagedInstanceCore,
#   ]
#   remote_access {
#     var.eks_node_group_key_name
#     source_security_group_ids = [module.VPC.private_security_group_id]
#   }
# }
data "aws_eks_node_group" "pokemon" {
  cluster_name    = var.eks_cluster_name
  node_group_name = var.eks_node_group_name
  depends_on = [ aws_eks_node_group.pokemon-frontend-nodes ]
}
output "autoscaling_group_names" {
  value = [for group in data.aws_eks_node_group.pokemon.resources[0].autoscaling_groups : group.name]
}


```
### Step 3: OIDC creation/IAM roles
```
data "aws_iam_policy_document" "pokemon_oidc_assume_role_policy" {
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
  name               = var.eks_oidc_role_name
}

resource "aws_iam_policy" "pokemon-policy" {
  name = var.eks_oidc_policy_name

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
### Step 4: EKS cluster AutoScaler Role 
```
data "aws_iam_policy_document" "pokemon_cluster_autoscaler_assume_role_policy" {
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
  name               = var.eks_cluster_autoscaler_role_name
}

resource "aws_iam_policy" "pokemon_cluster_autoscaler" {
  name = var.eks_cluster_autoscaler_policy_name

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
### Step 5: EKS Cluster addon EBS CSI
```
data "aws_iam_policy_document" "pokemon-ebs-csi" {
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
  name               = var.eks_csi_driver_role_name
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
  }

```

### Step 6: Cloudwatch metrics/dashboard
```
// Create SNS topic for eks-cluster-alarms
resource "aws_sns_topic" "eks-cluster-alarms" {
  name = var.sns_topic_name
}

// Subscription for SNS topic - sends notifications to the specified email
resource "aws_sns_topic_subscription" "eks_cluster_alarms_email" {
  topic_arn = aws_sns_topic.eks-cluster-alarms.arn
  protocol  = "email"
  endpoint  = var.sns_subscription_email
}
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

resource "aws_cloudwatch_metric_alarm" "eks_cluster_alarm" {
  alarm_name          = var.cloudwatch_alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CallCount"
  namespace           = "AWS/Usage"
  period              = 60  # Set the appropriate period in seconds
  statistic           = "Sum"
  threshold           = 1  # Set the appropriate threshold value
  alarm_actions       = [aws_sns_topic.eks-cluster-alarms.arn]

  dimensions = {
    Type      = "API"
    Resource  = "ListClusters"
    Service   = "EKS"
    Class     = "None"
  }

  alarm_description = "Alarm for EKS Cluster API Call Count"

}

```
### Step 7: EKS nodes CLoudwatch
```
// Create SNS topic for auto scaling groups in eks
resource "aws_sns_topic" "asg-alarms" {
  name = var.asg_sns_topic_name
}

// Subscription for SNS topic - sends notifications to the specified email
resource "aws_sns_topic_subscription" "asg_alarms_email" {
  topic_arn = aws_sns_topic.asg-alarms.arn
  protocol  = "email"
  endpoint  = var.asg_sns_subscription_email
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
              "${data.aws_eks_node_group.pokemon.resources[0].autoscaling_groups[0].name}"
            ],
            [
              "AWS/EC2",
              "DiskReadOps",
              "AutoScalingGroupName",
              "${data.aws_eks_node_group.pokemon.resources[0].autoscaling_groups[0].name}"
            ],
            [
              "AWS/EC2",
              "NetworkPacketsOut",
              "AutoScalingGroupName",
              "${data.aws_eks_node_group.pokemon.resources[0].autoscaling_groups[0].name}"
            ],
            [
              "AWS/EC2",
              "DiskWriteBytes",
              "AutoScalingGroupName",
              "${data.aws_eks_node_group.pokemon.resources[0].autoscaling_groups[0].name}"
            ],
            [
              "AWS/EC2",
              "StatusCheckFailed_Instance",
              "AutoScalingGroupName",
              "${data.aws_eks_node_group.pokemon.resources[0].autoscaling_groups[0].name}"
            ],
            [
              "AWS/EC2",
              "DiskWriteOps",
              "AutoScalingGroupName",
              "${data.aws_eks_node_group.pokemon.resources[0].autoscaling_groups[0].name}"
            ],
            [
              "AWS/EC2",
              "NetworkOut",
              "AutoScalingGroupName",
              "${data.aws_eks_node_group.pokemon.resources[0].autoscaling_groups[0].name}"
            ],
            [
              "AWS/EC2",
              "DiskReadBytes",
              "AutoScalingGroupName",
              "${data.aws_eks_node_group.pokemon.resources[0].autoscaling_groups[0].name}"
            ],
            [
              "AWS/EC2",
              "NetworkPacketsIn",
              "AutoScalingGroupName",
              "${data.aws_eks_node_group.pokemon.resources[0].autoscaling_groups[0].name}"
            ],
            [
              "AWS/EC2",
              "NetworkIn",
              "AutoScalingGroupName",
              "${data.aws_eks_node_group.pokemon.resources[0].autoscaling_groups[0].name}"
            ]
          ]
          region = "${var.aws_region}"
        }
      }
    ]
  })
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
  alarm_actions       = [aws_sns_topic.asg-alarms.arn] // Action to trigger SNS notification
  dimensions = {
    AutoScalingGroupName = "${data.aws_eks_node_group.pokemon.resources[0].autoscaling_groups[0].name}"
  }
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
              "${data.aws_eks_node_group.pokemon.resources[0].autoscaling_groups[0].name}"
            ]
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
              "${data.aws_eks_node_group.pokemon.resources[0].autoscaling_groups[0].name}"
            ]
          ]
          region = "${var.aws_region}"
        }
      }
    ]
  })
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

### 5. Export Kubectl

Once you get the kubeconfig yml file in the directory where the K8s manifest files are located use ```export KUBECONFIG=kubeconfig.yml```. This allows you o manipulate the EKS Cluster within local Terminal. But it will only work if you have the kubetl installed wihtin the terminal

## Conclusion
This setup will result in a fully functional AWS EKS cluster with configured IAM roles, VPC, worker nodes, OIDC for service accounts, autoscaling, and EBS CSI for persistent storage. Each step ensures the necessary permissions and configurations are in place for a secure and scalable Kubernetes environment on AWS.
