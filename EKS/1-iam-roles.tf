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