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




