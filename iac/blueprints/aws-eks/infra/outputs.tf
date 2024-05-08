output "clustes_id" {
  value = module.eks_blueprints.eks_cluster_id
}

output "cluster_primary_sg" {
  value = module.eks_blueprints.cluster_primary_security_group_id
}