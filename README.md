
[![Build Status](https://kantarware.visualstudio.com/KM-Engineering-AMS/_apis/build/status/terraform-helm-release?branchName=master)](https://kantarware.visualstudio.com/KM-Engineering-AMS/_build/latest?definitionId=3094&branchName=master)

# terraform-helm-release

Terraform module deployment helm chart k8s

## Description

Terraform module created to manage deployments helm charts in k8s cluster

## Example usage

- Deploy an nfs provisioner, providing a declarative file and individual entries.

```hcl

module "helm-release" {
  source = "../"
  config_context_cluster = "minikube"
  repository_name = "stable"
  repository_url = "https://kubernetes-charts.storage.googleapis.com"

  app = {
    "name"          = "nfs-server"
    "version"       = "1.0.0"
    "chart"         = "nfs-server-provisioner"
    "force_update"  = "true"
    "wait"          = "false"
    "recreate_pods" = "false"
    "deploy"        = 1
  }

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

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app | an application to deploy | <pre>object({<br>    name          = string<br>    version       = string<br>    chart         = string<br>    force_update  = bool<br>    wait          = bool<br>    recreate_pods = bool<br>    deploy        = number<br>  })</pre> | n/a | yes |
| config\_context\_cluster | Cluster context of the kube config (name of the kubeconfig cluster, --cluster flag in kubectl). Can be sourced from KUBE\_CTX\_CLUSTER. | `any` | n/a | yes |
| config\_path | Path to the kube config file. | `string` | `"~/.kube/config"` | no |
| namespace | namespace where to deploy an application | `string` | `"default"` | no |
| repository\_name | (Required) Chart repository name. | `string` | n/a | yes |
| repository\_password | (Optional) Password for HTTP basic authentication. | `string` | `null` | no |
| repository\_url | (Required) Chart repository URL. | `string` | n/a | yes |
| repository\_username | (Optional) Username for HTTP basic authentication. | `string` | `null` | no |
| set\_sensitive | Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff. | <pre>list(object({<br>    path  = string<br>    value = string<br>  }))</pre> | `null` | no |
| set\_strings | Value block with custom STRING values to be merged with the values yaml. | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `null` | no |
| values | Extra values | `list(string)` | `null` | no |

## Outputs

No output.

