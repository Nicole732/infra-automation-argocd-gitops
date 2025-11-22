# Helm Provider
provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    }
  }
}

#deploy ArgoCD using Helm chart
resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argo-cd.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "6.4.0"
  namespace        = "argocd" # create namespace if not exists
  create_namespace = true

  depends_on = [
    module.eks
  ]

}

#creates a secret to authenticate with gitops repo and read manifests 
resource "kubernetes_secret" "argocd_gitops_repo" {
  depends_on = [
    helm_release.argocd
  ]
  metadata {
    name      = "gitops-k8s-repo" #name of the secret in ArgoCD
    namespace = "argocd"
    labels = {
      "argo-cd.argoproj.io/secret-type" = "repository"
    }
  }

  #define as deploy tokens in the gitops repo
  data = {
    type     = "git"
    url      = var.gitops_url
    username = var.gitops_username
    password = var.gitops_password
  }

  type = "Opaque"
}