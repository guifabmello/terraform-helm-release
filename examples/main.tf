

module "helm-release" {
  source = "../"
  config_context = "minikube"

  release = {
    nfs-operator = {
      repository_name     = "stable"
      repository_url      = "https://kubernetes-charts.storage.googleapis.com"
      repository_username = null
      repository_password = null
      version             = "1.0.0"
      chart               = "nfs-server-provisioner"
      force_update        = true
      wait                = false
      recreate_pods       = false
      timeout             = "3600s"
      max_history         = 200
      values              = null
      set_strings = null
    }
    voyager-operator = {
      repository_name     = "appscode"
      repository_url      = "https://charts.appscode.com/stable"
      repository_username = null
      repository_password = null
      version             = "v12.0.0-rc.1"
      chart               = "voyager"
      force_update        = true
      wait                = false
      recreate_pods       = false
      timeout             = "3600s"
      max_history         = 200
      values              = null
      set_strings = [
        {
          name  = "cloudProvider"
          value = "minikube"
        }
      ]
    }
    prometheus-operator = {
      repository_name     = "stable"
      repository_url      = "https://kubernetes-charts.storage.googleapis.com"
      repository_username = null
      repository_password = null
      version             = "8.12.12"
      chart               = "prometheus-operator"
      force_update        = true
      wait                = false
      recreate_pods       = false
      timeout             = "3600s"
      max_history         = 200
      values = null
      set_strings = null
    }
    grafana-dashboards = {
      repository_name     = "amsrtm"
      repository_url      = "https://amsrtm.azurecr.io/helm/v1/repo"
      repository_username = "amsrtm"
      repository_password = "3kJyLrFKisV3YkygEK42Wv+q8DZLIQDm"
      version             = "1.1.0-release.207227"
      chart               = "grafana-dashboards"
      force_update        = true
      wait                = false
      recreate_pods       = false
      timeout             = "3600s"
      max_history         = 200
      values = null
      set_strings = null
    }
    rtm-dev = {
      repository_name     = "amsrtm"
      repository_url      = "https://amsrtm.azurecr.io/helm/v1/repo"
      repository_username = "amsrtm"
      repository_password = "3kJyLrFKisV3YkygEK42Wv+q8DZLIQDm"
      version             = "1.4.0-beta.207207"
      chart               = "rtm"
      force_update        = true
      wait                = false
      recreate_pods       = false
      timeout             = "3600s"
      max_history         = 200
      values = null
      set_strings = null
    }
  }
}