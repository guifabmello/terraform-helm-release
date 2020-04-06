data "helm_repository" "helm_chart_repo" {
  name = var.repository_name
  url  = var.repository_url

  username = var.repository_username
  password = var.repository_password
}