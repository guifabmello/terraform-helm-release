
variable "repository_name" {
  description = "(Required) Chart repository name."
  type = string
}

variable "repository_url" {
  description = "(Required) Chart repository URL."
  type        = string
}

variable "repository_username" {
  description = "(Optional) Username for HTTP basic authentication."
  type = string
  default = null
}

variable "repository_password" {
  description = "(Optional) Password for HTTP basic authentication."
  type = string
  default = null
}

variable "namespace" {
  description = "namespace where to deploy an application"
  default = "default"
}

variable "app" {
  description = "an application to deploy"
  type = object({
    name          = string
    version       = string
    chart         = string
    force_update  = bool
    wait          = bool
    recreate_pods = bool
    deploy        = number
  })
}

variable "values" {
  description = "Extra values"
  type        = list(string)
  default = null
}

variable "set_strings" {
  description = "Value block with custom STRING values to be merged with the values yaml."
  type = list(object({
    name  = string
    value = string
  }))
  default = null
}

variable "set_sensitive" {
  description = "Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff."
  type = list(object({
    path  = string
    value = string
  }))
  default = null
}