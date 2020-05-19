
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
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| config\_context | Cluster context of the kube config (name of the kubeconfig cluster, --cluster flag in kubectl). Can be sourced from KUBE\_CTX\_CLUSTER. | `any` | n/a | yes |
| config\_path | Path to the kube config file. | `string` | `"~/.kube/config"` | no |
| release | List application to deploy | <pre>map(object({<br>    repository_name = string<br>    repository_url = string<br>    repository_username = string<br>    repository_password = string<br>    version       = string<br>    chart         = string<br>    force_update  = bool<br>    timeout       = string<br>    max_history   = number<br>    wait          = bool<br>    recreate_pods = bool<br>    values = list(string)<br>    set = list(object({<br>      name  = string<br>      value = string<br>    }))<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| chart | The name of the chart. |
| namespace | Namespace is the kubernetes namespace of the release. |
| status | Status of the release. |
| values | The compounded values from values and set\* attributes. |
| version | A SemVer 2 conformant version string of the chart. |

