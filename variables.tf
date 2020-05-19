variable "config_context" {
  description = "Cluster context of the kube config (name of the kubeconfig cluster, --cluster flag in kubectl). Can be sourced from KUBE_CTX_CLUSTER."
}

variable "config_path" {
  description = "Path to the kube config file."
  default = "~/.kube/config"
}

variable "release" {
  description = "List application to deploy"
  type = map(object({
    repository_name = string
    repository_url = string
    repository_username = string
    repository_password = string
    version       = string
    chart         = string
    force_update  = bool
    timeout       = string
    max_history   = number
    wait          = bool
    recreate_pods = bool
    values = list(string)
    set = list(object({
      name  = string
      value = string
    }))
  }))
  default = {}
}