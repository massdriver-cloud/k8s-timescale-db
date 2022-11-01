resource "null_resource" "kubectl" {
  count = var.database_configuration.delete_volumes_on_destroy ? 1 : 0
  triggers = {
    #  trigger the null resource with each
    invokes_me_everytime = uuid()
    namespace            = var.namespace
    name                 = var.md_metadata.name_prefix
  }
  provisioner "local-exec" {
    when        = destroy
    command     = "kubectl delete -n $namespace pvc storage-volume-$name-timescaledb-0 wal-volume-$name-timescaledb-0 || true"
    interpreter = ["/bin/bash", "-c"]
    environment = {
      namespace = self.triggers.namespace
      name      = self.triggers.name
    }
  }
}
