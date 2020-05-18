# The namespace will only be created if it does not exist. 
# An efficient workaround to solve helm3  deficiency does not create namespaces.
resource "null_resource" "create_namespace" {

  for_each = var.release
  
  provisioner "local-exec" {
    
    command = "kubectl get namespace ${substr(each.key, 0, 100)} >/dev/null 2>&1 || kubectl create namespace ${substr(each.key, 0, 100)}"
  }
}