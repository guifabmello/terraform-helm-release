output "chart" {
  description = "The name of the chart."
  value = {
    for release in helm_release.this:
    release.name => release.chart
  }
}

output "namespace" {
  description = "Namespace is the kubernetes namespace of the release."
  value = {
    for release in helm_release.this:
    release.name => release.namespace
  }
}

output "status" {
  description = "Status of the release."
  value = {
    for release in helm_release.this:
    release.name => release.status
  }
}

output "version" {
  description = "A SemVer 2 conformant version string of the chart."
  value = {
    for release in helm_release.this:
    release.name => release.version
  }
}

output "values" {
  description = " The compounded values from values and set* attributes."
  value = {
    for release in helm_release.this:
    release.name => release.values
  }
}