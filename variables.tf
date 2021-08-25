variable "release" {
  description = "List application to deploy"
  type = map(object({
    repository_name = string
    chart         = string
    repository = string
    repository_username = string
    repository_password = string
    version       = string
    verify        = bool
    timeout       = number
    reuse_values  = bool
    reset_values  = bool
    force_update  = bool
    recreate_pods = bool
    max_history   = number
    wait          = bool
    values = list(string)
    set = list(object({
      name  = string
      value = string
    }))
    namespace = string
    create_namespace = bool
  }))
  default = {}
}