data "helm_repository" "helm_chart_repo" {

  for_each = var.release

  name = each.value.repository_name
  url  = each.value.repository_url

  username = each.value.repository_name
  password = each.value.repository_password
}