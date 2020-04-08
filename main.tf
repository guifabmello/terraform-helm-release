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
*   source = "app.terraform.io/KantarWare/release/helm"
*   config_context = "minikube"
* 
*   release = {
*     nfs-server = {
*       repository_name     = "stable"
*       repository_url      = "https://kubernetes-charts.storage.googleapis.com"
*       repository_username = null
*       repository_password = null
*       namespace           = "nfs-server"
*       version             = "1.0.0"
*       chart               = "nfs-server-provisioner"
*       force_update        = true
*       wait                = false
*       recreate_pods       = false
*       values = [
*         file("deploy.yaml")
*       ]
*       set_strings = [
*         {
*           name = "storageClass.name"
*           value = "nfs-server"
*         }
*       ]
*     }
*     mysql = {
*       repository_name     = "stable"
*       repository_url      = "https://kubernetes-charts.storage.googleapis.com"
*       repository_username = null
*       repository_password = null
*       namespace           = "default"
*       version             = "1.6.2"
*       chart               = "mysql"
*       force_update        = true
*       wait                = false
*       recreate_pods       = false
*       values = null
*       set_strings = null
*     }
*     prometheus-operator = {
*       repository_name     = "stable"
*       repository_url      = "https://kubernetes-charts.storage.googleapis.com"
*       repository_username = null
*       repository_password = null
*       namespace           = "mysql"
*       version             = "8.12.10"
*       chart               = "prometheus-operator"
*       force_update        = true
*       wait                = false
*       recreate_pods       = false
*       values = null
*       set_strings = null
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
  version = "v1.1.0"
  kubernetes {
    config_context = var.config_context
    config_path = var.config_path
  }
}

resource "helm_release" "this" {

  depends_on = [
    kubernetes_namespace.this
  ]

  for_each = var.release

  repository = data.helm_repository.helm_chart_repo[each.key].name

  namespace = substr(each.key, 0, 30)
  name = substr(each.key, 0, 30)
  chart = each.value.chart
  version = each.value.version
  force_update = each.value.force_update
  wait = each.value.wait
  recreate_pods = each.value.recreate_pods
  values = each.value.values


  dynamic "set_string" {
    iterator = item
    for_each = each.value.set_strings == null ? [] : each.value.set_strings

    content {
      name  = item.value.name
      value = item.value.value
    }
  }
}
