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
# resource "aws_iam_role_policy_attachment" "nodes-AmazonSSMManagedInstanceCore" {
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMManagedInstanceCore"
#   role       = aws_iam_role.pokemon-eks-node-group-nodes.name
# }


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
