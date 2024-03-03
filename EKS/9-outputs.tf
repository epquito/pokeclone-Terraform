output "eks_cluster_id" {
  value = aws_eks_cluster.pokemon-cluster.id 
}
output "node_group_name" {
  value = aws_eks_node_group.pokemon-frontend-nodes.node_group_name
}
