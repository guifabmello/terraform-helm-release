/**
* 
* [![Build Status](https://kantarware.visualstudio.com/KM-Engineering-AMS/_apis/build/status/terraform-helm-release?branchName=master)](https://kantarware.visualstudio.com/KM-Engineering-AMS/_build/latest?definitionId=3094&branchName=master)
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
* - Deploy an nfs provisioner, providing a declarative file and individual entries.
* 
* ```hcl
*
* module "helm-release" {
*   source = "../"
*   config_context_cluster = "minikube"
*   repository_name = "stable"
*   repository_url = "https://kubernetes-charts.storage.googleapis.com"
* 
*   app = {
*     "name"          = "nfs-server"
*     "version"       = "1.0.0"
*     "chart"         = "nfs-server-provisioner"
*     "force_update"  = "true"
*     "wait"          = "false"
*     "recreate_pods" = "false"
*     "deploy"        = 1
*   }
* 
*   values = [
*     file("deploy.yaml")
*   ]
* 
*   set_strings = [
*     {
*       name = "storageClass.name"
*       value = "nfs-server"
*     }
*   ]
* }
*
* ```
*/

provider "helm" {
  version = "v0.10.4"
  kubernetes {
    config_context = var.config_context
    config_path = var.config_path
  }
}

resource "helm_release" "this" {

  count         = var.app["deploy"]
  namespace     = var.namespace
  repository    = data.helm_repository.helm_chart_repo.name
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
