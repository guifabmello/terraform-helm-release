## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app | an application to deploy | <pre>object({<br>    name          = string<br>    version       = string<br>    chart         = string<br>    force_update  = bool<br>    wait          = bool<br>    recreate_pods = bool<br>    deploy        = number<br>  })</pre> | n/a | yes |
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

