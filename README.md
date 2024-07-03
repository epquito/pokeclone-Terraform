# Pokemon Terraform Configuration for Amazon EKS
The diagram illustrates a comprehensive AWS infrastructure deployment tailored for full-scale production. However, our current focus is solely on the public-facing aspect of the deployment. Nonetheless, it's worth noting that the groundwork has been established to seamlessly transition into a complete public/private EKS deployment when needed.

  ![Alt Text](https://github.com/epquito/pokeclone-Terraform/blob/master/AWS-Terraform-Architecture-Structure.jpeg)

## Introduction
This project provides a comprehensive Terraform configuration designed for deploying a highly available and scalable Amazon Elastic Kubernetes Service (EKS) environment. It includes setups for a VPC, subnets, Internet Gateway (IGW), NAT Gateway, route tables, and an Amazon RDS instance, ensuring a robust infrastructure for containerized applications.

## Variables for each module
## Variables tf for VPC:
```

# VPC
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string

}

variable "vpc_name" {
  description = "how the vpc will shouw up on the AWS console"
  type = string

  
}

# Private Subnet 1
variable "private_subnet1_cidr_block" {
  description = "CIDR block for private subnet 1"
  type        = string

}
variable "private_subnet1_az" {
  description = "subnet availibility zone"
  type = string

  
}

# Private Subnet 2
variable "private_subnet2_cidr_block" {
  description = "CIDR block for private subnet 2"
  type        = string

}
variable "private_subnet2_az" {
  description = "subnet availibility zone"
  type = string

  
}

# Public Subnet 1
variable "public_subnet1_cidr_block" {
  description = "CIDR block for public subnet 1"
  type        = string

}
variable "public_subnet1_az" {
  description = "subnet availibility zone"
  type = string

  
}

# Public Subnet 2
variable "public_subnet2_cidr_block" {
  description = "CIDR block for public subnet 2"
  type        = string

}
variable "public_subnet2_az" {
  description = "subnet availibility zone"
  type = string
  
}

# Internet Gateway
variable "internet_gateway_name" {
  description = "Name of the Internet Gateway"
  type        = string
}

# Elastic IP
variable "nat_gateway_eip_name" {
  description = "Name of the Elastic IP for NAT Gateway"
  type        = string
}

# NAT Gateway
variable "nat_gateway_name" {
  description = "Name of the NAT Gateway"
  type        = string
}

# Route Tables
variable "private_route_table_name" {
  description = "Name of the private route table"
  type        = string
}

variable "public_route_table_name" {
  description = "Name of the public route table"
  type        = string
}

## Route table ACL

variable "public_pokemon_acl" {
  description = "public netwrok acl name"
  type = string
  
}
variable "private_pokemon_acl" {
  description = "public netwrok acl name"
  type = string
  
}


# Security Groups
variable "public_security_group_name" {
  description = "Name of the public security group"
  type        = string
}

variable "operating_system_ip" {
  description = "personal ipv4"
  type = string
  
}

variable "private_security_group_name" {
  description = "Name of the private security group"
  type        = string
}




```
## Variables tf for EKS:
```
variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string

}

variable "eks_cluster_role_name" {
  description = "Name of the IAM role for EKS cluster"
  type        = string

}
variable "module_subnet_ids" {
  description = "From module VPC get all subnet IDS"
  type = list(string)
}
variable "eks_cluster_version" {
  description = "EKS cluster/platform version"
  type = string
  
}
variable "cluster_ipv4_range" {
  description = "cluster service ipv4 cidr range"
  type = string
  
}

variable "eks_cluster_log_group_name" {
  description = "Name of the CloudWatch Log Group for EKS cluster"
  type        = string

}

variable "eks_node_group_name" {
  description = "Name of the EKS node group"
  type        = string

}

variable "module_public_subnet_ids" {
  description = "from module VPC get only the public subnet IDS for the front facing nodes"
    type = list(string)
  
}


variable "eks_node_group_instance_type" {
  description = "Instance type for EKS node group"
  type        = string

}

variable "eks_node_group_desired_size" {
  description = "Desired number of instances in EKS node group"
  type        = number

}

variable "eks_node_group_max_size" {
  description = "Maximum number of instances in EKS node group"
  type        = number

}

variable "eks_node_group_min_size" {
  description = "Minimum number of instances in EKS node group"
  type        = number

}

variable "eks_node_group_key_name" {
  description = "SSH key name for EKS node group instances"
  type        = string

}

variable "eks_node_group_security_group" {
  description = "public-security group"
  type = list(string)
  
}
variable "node_group_ami_type" {
  description = "Depending on the EKS cluster versions the AMI type will very "
  type = string
  
}

variable "eks_oidc_role_name" {
  description = "Name of the IAM role for EKS OIDC"
  type        = string
}

variable "eks_oidc_policy_name" {
  description = "Name of the IAM policy for EKS OIDC"
  type        = string
}
variable "eks_cluster_autoscaler_role_name" {
  description = "Name of the IAM role for EKS cluster autoscaler"
  type        = string
}
variable "eks_cluster_autoscaler_policy_name" {
  description = "Name of the IAM policy for EKS cluster autoscaler"
  type        = string
}

variable "eks_csi_driver_role_name" {
  description = "Name of the IAM role for EBS CSI driver"
  type        = string

}
variable "eks_ebs_csi_add_on_version" {
  description = "Depending on the EKS cluster version the compatibility of the Add on version will very"
  type = string
  
}
```

## Variables tf for SNS
```
# SNS Topic
variable "sns_topic_name_eventbridge" {
  description = "Name of the SNS Topic for eventbridge"
  type = string
}

variable "sns_topic_name_eks" {
  description = "Name of the SNS Topic for eks"
  type = string
}
variable "asg_sns_topic_name"{
  description = "Name of the SNS Topic for sns"
  type = string

}

#sns subscriptions 
variable "sns_topic_email_eventbridge" {
  description = "email used for the sns topic"
  type = string
}

variable "sns_subscription_email_EKS" {
  description = "email used for the sns  for EKS"
  type = string
}


variable "asg_sns_subscription_email" {
  description = "email used for the sns topic for ASG of EKS"
  type = string
}

```
## Variables for CloudWatch

```
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


```
## Variables for EventBridge

```
# IAM Role for EventBridge
variable "iam_role_name" {
  description = "Name of the IAM role for EventBridge"
  type        = string
}

variable "db_instance_identifier_id" {
  description = "db instance identifier id"
  type        = string
}
variable "eventbridge_db_resource" {
    description = "Database resource so eventbridge starts up after rds is up"
  
}
```

## Variables for RDS

```
# RDS
variable "db_subnet_group_name" {
  description = "Name of the RDS DB subnet group"
  type        = string

}
variable "rds_subnet_group_ids" {
    type = list(string)
    description = "list of subnet ids"
  
}

variable "db_instance_identifier" {
  description = "Identifier for the RDS instance"
  type        = string
}

variable "db_name" {
  description = "Name of the RDS database"
  type        = string
}

variable "db_username" {
  description = "Username for the RDS instance"
  type        = string
}

variable "db_password" {
  description = "Password for the RDS instance"
  type        = string
}
variable "rds-security_ids" {
    description = "list of security group IDs"
}


```
### Creating Modules for each AWS Service being used in this deployment
### Step 1: Create Modules(Directory)
```
mkdir VPC EKS SNS EventBridge CloudWatch RDS
```
### Step 2: VPC Creation
- Configuring your Virtual private cloud module is assential for 
  the deployments of the AWS services
- Virtual private cloud(VPC) 
- Internet gateway (IGW)
- Elastic IP(EIP)
- Nat Gateway(NATGW)
- Route Tables
- Subnets
- Network Access Control list(NACL)
- Security groups (SG)

```
resource "aws_vpc" "pokemon" {

    cidr_block = var.vpc_cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      Name = var.vpc_name
    }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id = aws_vpc.pokemon.id 
  cidr_block = var.private_subnet1_cidr_block
  availability_zone = var.private_subnet1_az

  tags = {
    "Name" = "private-subnet-1"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/pokemon-cluster" = "owned"

  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id = aws_vpc.pokemon.id 
  cidr_block = var.private_subnet2_cidr_block
  availability_zone = var.private_subnet2_az

  tags = {
    "Name" = "private-subnet-2"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/pokemon-cluster" = "owned"

  }
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id = aws_vpc.pokemon.id 
  cidr_block = var.public_subnet1_cidr_block
  availability_zone = var.public_subnet1_az
  map_public_ip_on_launch = true

  tags = {
    "Name" = "public-subnet-1"
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/pokemon-cluster" = "owned"

  }
}
resource "aws_subnet" "public-subnet-2" {
  vpc_id = aws_vpc.pokemon.id 
  cidr_block = var.public_subnet2_cidr_block
  availability_zone = var.public_subnet2_az
  map_public_ip_on_launch = true

  tags = {
    "Name" = "public-subnet-2"
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/pokemon-cluster" = "owned"

  }
}

resource "aws_internet_gateway" "pokemon-igw" {
    vpc_id = aws_vpc.pokemon.id
    tags = {
      Name = var.internet_gateway_name
    }
}

resource "aws_eip" "pokemon-nat" {
    domain = "vpc"
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

#private route table
resource "aws_route_table" "private-route-pokemon" {
  vpc_id = aws_vpc.pokemon.id
  
  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.pokemon-nat-gw.id
  }


  tags = {
    Name = var.private_route_table_name
  }
}
#public route table
resource "aws_default_route_table" "public-route-pokemon" {
  default_route_table_id = aws_vpc.pokemon.default_route_table_id

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }

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
  route_table_id = aws_default_route_table.public-route-pokemon.id
}

resource "aws_route_table_association" "public-subnet-2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_default_route_table.public-route-pokemon.id
}

resource "aws_default_network_acl" "public_pokemon_acl" {
    default_network_acl_id = aws_vpc.pokemon.default_network_acl_id
    subnet_ids             = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]

    # Allow all inbound traffic
    ingress {
        protocol   = "-1"
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }

    # Allow all outbound traffic
    egress {
        protocol   = "-1"
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }

    tags = {
        Name = var.public_pokemon_acl
    }
}


resource "aws_network_acl" "private_pokemon_acl" {
    vpc_id = aws_vpc.pokemon.id
    subnet_ids = [ aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id ]
    ingress {
        protocol   = "-1"
        rule_no    = 100
        action     = "allow"
        cidr_block = var.vpc_cidr_block
        from_port  = 0
        to_port    = 0
    }


 
    egress {
        protocol   = "-1"
        rule_no    = 100
        action     = "allow"
        cidr_block = var.vpc_cidr_block
        from_port  = 0
        to_port    = 0
    }

    tags = {
        Name = var.private_pokemon_acl

    }

  
}

resource "aws_security_group" "public_sg" {
    name        = var.public_security_group_name
    description = "Public Security Group"
    vpc_id      = aws_vpc.pokemon.id  # Replace with your VPC ID
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        self        = true
    }
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [ var.vpc_cidr_block ]
    }
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [ var.operating_system_ip ]
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
        self        = true
    }

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [var.vpc_cidr_block,var.operating_system_ip]
    }

 

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output "private_subnet_1_id" {
    value = aws_subnet.private-subnet-1.id
  
}
output "private_subnet_2_id" {
    value = aws_subnet.private-subnet-2.id
  
}
output "public_subnet_1_id" {
    value = aws_subnet.public-subnet-1.id
  
}
output "public_subnet_2_id" {
    value = aws_subnet.public-subnet-2.id
}

output "public_security_group" {
    value = [ aws_security_group.public_sg.id ]
  
}
output "private_security_group" {
    value = aws_security_group.private_sg.id
  
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
output "vpc_id" {
    value = aws_vpc.pokemon.id
  
}


```
### Step 3: RDS Database
- Configuring Relational Database Service
- Relational Database Service(RDS)
- Subnet group

```
# Create a DB subnet group
resource "aws_db_subnet_group" "db-subnet-group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.rds_subnet_group_ids
}

# Create an RDS instance
resource "aws_db_instance" "pokemonDatabase" {
  allocated_storage      = 20
  identifier             = var.db_instance_identifier
  db_name                = var.db_name
  engine                 = "postgres"
  engine_version         = "12.17"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.postgres12"
  publicly_accessible    = true
  skip_final_snapshot    = true
  deletion_protection    = false
  vpc_security_group_ids = ["${var.rds-security_ids}"]

  db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.name
  iam_database_authentication_enabled = true

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  backup_retention_period = 1
}


output "rds_instance_identifier" {
    value = aws_db_instance.pokemonDatabase.identifier
  
}

output "rds_resource" {
    value = aws_db_instance.pokemonDatabase
  
}
```
### Step 4: EventBridge 
- Configuring Event Bridge
- IAM Roles for EventBridge
- IAM policy attachment
- Schedular
- Outputs
```
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
  

  schedule_expression = "cron(0 * * * ? *)"


  target {
    arn = "arn:aws:scheduler:::aws-sdk:rds:createDBSnapshot"
    role_arn = aws_iam_role.eventbridge_role.arn

    input = jsonencode({
      DbInstanceIdentifier = "${var.db_instance_identifier_id}"  # Replace with the correct DB instance identifier
      DbSnapshotIdentifier = "pokeclone-db-snapshot-schedule"
    })
  }
  depends_on = [var.eventbridge_db_resource]
}
output "event_bridge_schedular" {
    value = aws_scheduler_schedule.rds_snapshot_schedule.schedule_expression
  
}
```

### Step 5: CloudWatch
- Configuring AWS CLoudwatch for monitoring services 
- Metric Alarms
- Dashboards
- Event Rule/ Targets
```
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
# Create CloudWatch Events rules
resource "aws_cloudwatch_event_rule" "rds_snapshot_rule" {
  name        = var.cloudwatch_event_rule_name
  description = "Rule to trigger RDS snapshots"
  schedule_expression = var.scheduled_expression
}

# Add a target to the CloudWatch Events rule (SNS topic)
resource "aws_cloudwatch_event_target" "rds_snapshot_target" {
  rule      = aws_cloudwatch_event_rule.rds_snapshot_rule.name
  arn       = var.sns_topic_for_event_arn
}

```
## Step 6 : SNS
- Configuring Simple Notification system
- IAM Role
- IAM Policy
- SNS topic
- SNS Subscriptions
```
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

# Create an SNS Topic
resource "aws_sns_topic" "db_snapshot_event_topic" {
  name = var.sns_topic_name_eventbridge
}
// Create SNS topic for eks-cluster-alarms
resource "aws_sns_topic" "eks-cluster-alarms" {
  name = var.sns_topic_name_eks
}
// Create SNS topic for auto scaling groups in eks
resource "aws_sns_topic" "asg-alarms" {
  name = var.asg_sns_topic_name
}

# Subscribe edwinquito45@gmail.com to the SNS Topic
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.db_snapshot_event_topic.arn
  protocol  = "email"
  endpoint  = var.sns_topic_email_eventbridge
}
// Subscription for SNS topic - sends notifications to the specified email
resource "aws_sns_topic_subscription" "eks_cluster_alarms_email" {
  topic_arn = aws_sns_topic.eks-cluster-alarms.arn
  protocol  = "email"
  endpoint  = var.sns_subscription_email_EKS
}
// Subscription for SNS topic - sends notifications to the specified email
resource "aws_sns_topic_subscription" "asg_alarms_email" {
  topic_arn = aws_sns_topic.asg-alarms.arn
  protocol  = "email"
  endpoint  = var.asg_sns_subscription_email
}

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

```

## Step 7: EKS
- Configure Elastic Kuerbenetes Service
- IAM role
- IAM policy
- Cluster
- OIDC
- Node Groups
- EBS CSI
- Auto Scaling group

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
  # version = "1.30"
  version = var.eks_cluster_version
  

  vpc_config {
    endpoint_private_access = true 
    endpoint_public_access = true
    subnet_ids = var.module_subnet_ids
    security_group_ids = var.eks_node_group_security_group ## change module value to new vpc outputs
  }
  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_ipv4_range
  }


  enabled_cluster_log_types = ["api", "authenticator", "audit", "scheduler", "controllerManager"]
  depends_on = [aws_iam_role_policy_attachment.pokemon-AmazonEKSClusterPolicy]
}
resource "aws_cloudwatch_log_group" "eks_control_plane_logs" {
  name              = var.eks_cluster_log_group_name
  retention_in_days = 7
}

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
  

  subnet_ids = var.module_public_subnet_ids  ## change to new VPC module subnet IDs
  capacity_type  = "ON_DEMAND"
  # ami_type = "AL2_x86_64"
  ami_type = var.node_group_ami_type
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
    source_security_group_ids = var.eks_node_group_security_group
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

    # addon_version            = "v1.31.0-eksbuild.1"
    addon_version  = var.eks_ebs_csi_add_on_version
    service_account_role_arn = aws_iam_role.eks_ebs_csi_driver.arn
  }

output "eks_cluster_id" {
  value = aws_eks_cluster.pokemon-cluster.id 
}
output "node_group_name" {
  value = aws_eks_node_group.pokemon-frontend-nodes.node_group_name
}

output "full_eks_asg_id" {
  value = data.aws_eks_node_group.pokemon.resources[0].autoscaling_groups[0].name
}

```

## Final Step 
- After creating each module(directory) for each service being deployed
- Configure the root TF files (providers.tf, main.tf, variables.tf)

```
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.55.0"
    }
  }
}

provider "aws" {
    region = var.aws_region
    profile = var.aws_profile
}

module "VPC" {
    source = "./VPC"
    vpc_cidr_block = var.vpc_cidr_block
    vpc_name = var.vpc_name
    private_subnet1_cidr_block = var.private_subnet1_cidr_block
    private_subnet1_az = var.private_subnet1_az
    private_subnet2_cidr_block = var.private_subnet2_cidr_block
    private_subnet2_az = var.private_subnet2_az
    public_subnet1_cidr_block = var.public_subnet1_cidr_block
    public_subnet1_az = var.public_subnet1_az
    public_subnet2_cidr_block = var.public_subnet2_cidr_block
    public_subnet2_az = var.public_subnet2_az
    internet_gateway_name = var.internet_gateway_name
    nat_gateway_eip_name = var.nat_gateway_eip_name
    nat_gateway_name = var.nat_gateway_name
    private_route_table_name = var.private_route_table_name
    public_route_table_name = var.public_route_table_name
    public_pokemon_acl = var.public_pokemon_acl
    private_pokemon_acl = var.private_pokemon_acl
    public_security_group_name = var.public_security_group_name
    operating_system_ip = var.operating_system_ip
    private_security_group_name = var.private_security_group_name
}

module "RDS" {
    source = "./RDS"
    db_subnet_group_name = var.db_subnet_group_name
    rds_subnet_group_ids = module.VPC.public_subnet_ids
    db_instance_identifier = var.db_instance_identifier
    db_name = var.db_name
    db_username = var.db_username
    db_password = var.db_password
    rds-security_ids = module.VPC.public_security_group
}
module "EKS" {
    source = "./EKS"
    eks_cluster_name = var.eks_cluster_name
    eks_cluster_role_name = var.eks_cluster_role_name
    module_subnet_ids = module.VPC.subnet_ids
    eks_cluster_log_group_name = var.eks_cluster_log_group_name
    eks_cluster_version = var.eks_cluster_version
    cluster_ipv4_range = var.cluster_ipv4_range
    eks_node_group_name =var.eks_node_group_name
    module_public_subnet_ids = module.VPC.public_subnet_ids
    eks_node_group_instance_type = var.eks_node_group_instance_type
    eks_node_group_desired_size = var.eks_node_group_desired_size
    eks_node_group_max_size = var.eks_node_group_max_size
    eks_node_group_min_size = var.eks_node_group_min_size
    eks_node_group_key_name = var.eks_node_group_key_name
    eks_node_group_security_group = module.VPC.public_security_group
    node_group_ami_type = var.node_group_ami_type
    eks_oidc_role_name = var.eks_oidc_role_name
    eks_oidc_policy_name = var.eks_oidc_policy_name
    eks_cluster_autoscaler_role_name = var.eks_cluster_autoscaler_role_name
    eks_cluster_autoscaler_policy_name = var.eks_cluster_autoscaler_policy_name
    eks_csi_driver_role_name = var.eks_csi_driver_role_name
    eks_ebs_csi_add_on_version = var.eks_ebs_csi_add_on_version
}
module "SNS" {
    source = "./SNS"
    sns_topic_name_eventbridge = var.sns_topic_name_eventbridge
    sns_topic_email_eventbridge = var.sns_topic_email_eventbridge
    sns_topic_name_eks = var.sns_topic_name_eks
    sns_subscription_email_EKS = var.sns_subscription_email_EKS
    asg_sns_topic_name = var.asg_sns_topic_name
    asg_sns_subscription_email = var.asg_sns_subscription_email

}
module "EventBridge" {
    source = "./EventBridge"
    iam_role_name = var.iam_role_name
    db_instance_identifier_id = module.RDS.rds_instance_identifier
    eventbridge_db_resource = module.RDS.rds_resource 
}
module "CloudWatch" {
    source = "./CloudWatch"
    cloudwatch_event_rule_name = var.cloudwatch_event_rule_name
    scheduled_expression = module.EventBridge.event_bridge_schedular
    sns_topic_for_event_arn = module.SNS.sns_topic_event_arn
    cloudwatch_dashboard_name = var.cloudwatch_dashboard_name
    aws_region = var.aws_region
    aws_eks_asg_id = module.EKS.full_eks_asg_id
    cloudwatch_alarm_name = var.cloudwatch_alarm_name
    asg_cloudwatch_dashboard_name = var.asg_cloudwatch_dashboard_name
    asg_cloudwatch_alarm_name = var.asg_cloudwatch_alarm_name
    node_line_graph_dashboard_name = var.node_line_graph_dashboard_name
    eks_alarm_topic_arn = module.SNS.sns_topic_EKS_arn
    asg_alarm_topic_arn = module.SNS.sns_topic_ASG_arn

}


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
