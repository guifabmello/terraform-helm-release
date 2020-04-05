provider "kubernetes" {
  config_context_cluster   = "minikube"
}

module "helm-release" {
  source = "../"

  repository_name = "stable"
  repository_url = "https://kubernetes-charts.storage.googleapis.com"

  app = {
    "name"          = "nfs-server"
    "version"       = "1.0.0"
    "chart"         = "nfs-server-provisioner"
    "force_update"  = "true"
    "wait"          = "false"
    "recreate_pods" = "false"
    "deploy"        = 1
  }
}