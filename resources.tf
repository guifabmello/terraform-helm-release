resource "kubernetes_namespace" "this" {
  for_each = var.release
  metadata {
    annotations = {
      name = substr(each.key, 0, 100)
    }

    labels = {
      provisioner = "terraform"
    }

    name = substr(each.key, 0, 100)
  }
}