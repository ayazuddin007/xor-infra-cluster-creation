output "identity-oidc-issuer" {
  value = data.aws_eks_cluster.example.identity[0].oidc[0].issuer
}