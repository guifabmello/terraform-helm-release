

# terraform-helm-release

Terraform module deployment helm chart k8s

## Description

Terraform module created to manage deployments helm charts in k8s cluster

## Example usage

```hcl
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app | an application to deploy | <pre>object({<br>    name          = string<br>    version       = string<br>    chart         = string<br>    force_update  = bool<br>    wait          = bool<br>    recreate_pods = bool<br>    deploy        = number<br>  })</pre> | n/a | yes |
| namespace | namespace where to deploy an application | `any` | n/a | yes |
| repository | Helm repository | `string` | n/a | yes |
| set\_sensitive | Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff. | <pre>list(object({<br>    path  = string<br>    value = string<br>  }))</pre> | `null` | no |
| set\_strings | Value block with custom STRING values to be merged with the values yaml. | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | n/a | yes |
| values | Extra values | `list(string)` | n/a | yes |

## Outputs

No output.

