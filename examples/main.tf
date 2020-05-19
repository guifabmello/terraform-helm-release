

module "helm-release" {
  source         = "../"
  config_context = "minikube"

  release = {
    nfs-operator = {
      repository_name     = "stable"
      chart               = "nfs-server-provisioner"
      repository_url      = "https://kubernetes-charts.storage.googleapis.com"
      repository_username = null
      repository_password = null
      version             = "1.0.0"
      verify              = false
      reuse_values        = false
      reset_values        = false
      force_update        = false
      timeout             = 3600
      recreate_pods       = false
      max_history         = 200
      wait                = false
      values              = null
      set                 = null

      create_namespace = true
    }
    voyager-operator = {
      repository_name     = "appscode"
      chart               = "voyager"
      repository_url      = "https://charts.appscode.com/stable"
      repository_username = null
      repository_password = null
      version             = "v12.0.0-rc.1"
      verify              = false
      reuse_values        = false
      reset_values        = false
      force_update        = false
      timeout             = 3600
      recreate_pods       = false
      max_history         = 200
      wait                = false
      values              = null
      set = [
        {
          name  = "cloudProvider"
          value = "minikube"
        }
      ]

      create_namespace = true
    }
  }
}