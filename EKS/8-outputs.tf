output "eks" {
  value = <<EOF
###################################### KUBECONFIG ###########################################

        aws eks --region us-east-1 update-kubeconfig --name pokemon-cluster
EOF
}