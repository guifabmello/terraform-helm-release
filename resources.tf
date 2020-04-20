data "helm_repository" "helm_chart_repo" {

  for_each = var.release

  name = each.value.repository_name
  url  = each.value.repository_url

  username = each.value.repository_name
  password = each.value.repository_password
}

resource "kubernetes_namespace" "this" {
  for_each = var.release
  metadata {
    annotations = {
      name = substr(each.key, 0, 30)
    }

    labels = {
      privisioner = "terraform"
    }

    name = substr(each.key, 0, 30)
  }
}