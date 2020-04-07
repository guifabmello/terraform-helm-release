

module "helm-release" {
  source = "../"
  config_context = "minikube"

  release = {
    nfs-server = {
      repository_name     = "stable"
      repository_url      = "https://kubernetes-charts.storage.googleapis.com"
      repository_username = null
      repository_password = null
      namespace           = "default"
      version             = "1.0.0"
      chart               = "nfs-server-provisioner"
      force_update        = true
      wait                = false
      recreate_pods       = false
      values = [
        file("deploy.yaml")
      ]
      set_strings = [
        {
          name = "storageClass.name"
          value = "nfs-server"
        }
      ]
    }
    mysql = {
      repository_name     = "stable"
      repository_url      = "https://kubernetes-charts.storage.googleapis.com"
      repository_username = null
      repository_password = null
      namespace           = "default"
      version             = "1.6.2"
      chart               = "mysql"
      force_update        = true
      wait                = false
      recreate_pods       = false
      values = null
      set_strings = null
    }
    prometheus-operator = {
      repository_name     = "stable"
      repository_url      = "https://kubernetes-charts.storage.googleapis.com"
      repository_username = null
      repository_password = null
      namespace           = "default"
      version             = "8.12.10"
      chart               = "prometheus-operator"
      force_update        = true
      wait                = false
      recreate_pods       = false
      values = null
      set_strings = null
    }
  }
}