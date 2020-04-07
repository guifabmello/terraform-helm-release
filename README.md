
[![Build Status](https://kantarware.visualstudio.com/KM-Engineering-AMS/_apis/build/status/terraform-helm-release?branchName=master)](https://kantarware.visualstudio.com/KM-Engineering-AMS/_build/latest?definitionId=3094&branchName=master)

# terraform-helm-release

Terraform module deployment helm chart k8s

## Description

This module dynamically manages helm charts deployments in a k8s cluster.  
Just specify in a list the deployments in a single module call.
## Example usage

- Deploy an nfs-provisioner, providing a declarative file and individual entries.
- Deploy mysql.
- Deploy prometheus-operator.

```hcl
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
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| config\_context | Cluster context of the kube config (name of the kubeconfig cluster, --cluster flag in kubectl). Can be sourced from KUBE\_CTX\_CLUSTER. | `any` | n/a | yes |
| config\_path | Path to the kube config file. | `string` | `"~/.kube/config"` | no |
| release | List application to deploy | <pre>map(object({<br>    repository_name = string<br>    repository_url = string<br>    repository_username = string<br>    repository_password = string<br>    namespace = string<br>    version       = string<br>    chart         = string<br>    force_update  = bool<br>    wait          = bool<br>    recreate_pods = bool<br>    values = list(string)<br>    set_strings = list(object({<br>      name  = string<br>      value = string<br>    }))<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| chart | The name of the chart. |
| namespace | Namespace is the kubernetes namespace of the release. |
| status | Status of the release. |
| values | The compounded values from values and set\* attributes. |
| version | A SemVer 2 conformant version string of the chart. |

