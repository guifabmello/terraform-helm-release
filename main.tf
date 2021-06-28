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
* This module dynamically manages helm charts deployments in a k8s cluster.
* Just specify in a list the deployments in a single module call. 
* ## Example usage
*
* - Deploy an nfs-provisioner, providing a declarative file and individual entries.
* - Deploy mysql.
* - Deploy prometheus-operator.
* 
* ```hcl
* module "helm-release" {
*   source         = "../"
*   config_context = "minikube"
* 
*   release = {
*     nfs-operator = {
*       repository_name     = "stable"
*       chart               = "nfs-server-provisioner"
*       repository          = "https://kubernetes-charts.storage.googleapis.com"
*       repository_username = null
*       repository_password = null
*       version             = "1.0.0"
*       verify              = false
*       reuse_values        = false
*       reset_values        = false
*       force_update        = false
*       timeout             = 3600
*       recreate_pods       = false
*       max_history         = 200
*       wait                = false
*       values              = null
*       set                 = null
* 
*       create_namespace = true
*     }
*     voyager-operator = {
*       repository_name     = "appscode"
*       chart               = "voyager"
*       repository          = "https://charts.appscode.com/stable"
*       repository_username = null
*       repository_password = null
*       version             = "v12.0.0-rc.1"
*       verify              = false
*       reuse_values        = false
*       reset_values        = false
*       force_update        = false
*       timeout             = 3600
*       recreate_pods       = false
*       max_history         = 200
*       wait                = false
*       values              = null
*       set = [
*         {
*           name  = "cloudProvider"
*           value = "minikube"
*         }
*       ]
* 
*       create_namespace = true
*     }
*   }
* }
* ```
*/

provider "kubernetes" {
  config_context_cluster   = var.config_context
  config_path = var.config_path
}

provider "helm" {
  #version = "2.3.2"
  kubernetes {
    config_context = var.config_context
    config_path = var.config_path
  }
}

resource "helm_release" "this" {

  for_each = var.release

  name = substr(each.key, 0, 30)
  chart = each.value.chart
  repository = each.value.repository
  repository_username = each.value.repository_name
  repository_password = each.value.repository_password
  version = each.value.version
  namespace = substr(each.key, 0, 30)
  verify = each.value.verify
  timeout = each.value.timeout
  reuse_values = each.value.reuse_values
  reset_values = each.value.reset_values
  force_update = each.value.force_update
  recreate_pods = each.value.recreate_pods
  max_history = each.value.max_history
  wait = each.value.wait
  values = each.value.values

  dynamic "set" {
    iterator = item
    for_each = each.value.set == null ? [] : each.value.set

    content {
      name  = item.value.name
      value = item.value.value
    }
  }

  create_namespace = each.value.create_namespace
}
