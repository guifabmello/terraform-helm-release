
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
  source         = "../"
  config_context = "minikube"

  release = {
    nfs-operator = {
      repository_name     = "stable"
      chart               = "nfs-server-provisioner"
      repository          = "https://kubernetes-charts.storage.googleapis.com"
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
      repository          = "https://charts.appscode.com/stable"
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
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| config\_context | Cluster context of the kube config (name of the kubeconfig cluster, --cluster flag in kubectl). Can be sourced from KUBE\_CTX\_CLUSTER. | `any` | n/a | yes |
| config\_path | Path to the kube config file. | `string` | `"~/.kube/config"` | no |
| release | List application to deploy | <pre>map(object({<br>    repository_name = string<br>    chart         = string<br>    repository = string<br>    repository_username = string<br>    repository_password = string<br>    version       = string<br>    verify        = bool<br>    timeout       = number<br>    reuse_values  = bool<br>    reset_values  = bool<br>    force_update  = bool<br>    recreate_pods = bool<br>    max_history   = number<br>    wait          = bool<br>    values = list(string)<br>    set = list(object({<br>      name  = string<br>      value = string<br>    }))<br>    create_namespace = bool<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| chart | The name of the chart. |
| namespace | Namespace is the kubernetes namespace of the release. |
| status | Status of the release. |
| values | The compounded values from values and set\* attributes. |
| version | A SemVer 2 conformant version string of the chart. |

