/**
*
*
* # terraform-helm-release
*
* Terraform module deployment helm chart k8s
*
* ## Description
*
* Terraform module created to manage deployments helm charts in k8s cluster
*
* ## Example usage
*
*
* ```hcl
* ```
*/

resource helm_release this {
  count         = var.app["deploy"]
  namespace     = var.namespace
  repository    = var.repository
  name          = var.app["name"]
  version       = var.app["version"]
  chart         = var.app["chart"]
  force_update  = var.app["force_update"]
  wait          = var.app["wait"]
  recreate_pods = var.app["recreate_pods"]
  values        = var.values

  dynamic "set_string" {
    iterator = item
    for_each = var.set_strings == null ? [] : var.set_strings

    content {
      name  = item.value.name
      value = item.value.value
    }
  }

  dynamic "set_sensitive" {
    iterator = item
    for_each = var.set_sensitive == null ? [] : var.set_sensitive

    content {
      name  = item.value.path
      value = item.value.value
    }
  }
}