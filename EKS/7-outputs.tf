output "eks_cluster_id" {
  value = aws_eks_cluster.pokemon-cluster.id 
}
output "node_group_name" {
  value = aws_eks_node_group.pokemon-frontend-nodes.node_group_name
}

output "full_eks_asg_id" {
  value = data.aws_eks_node_group.pokemon.resources[0].autoscaling_groups[0].name
}