locals {
  current_context = var.md_metadata.name_prefix
  clusters = [{
    "name" : var.md_metadata.name_prefix,
    "server" : local.k8s_host,
    certificate_authority_data = base64encode(local.k8s_certificate_authority)
  }]
  contexts = [{
    "name" : var.md_metadata.name_prefix,
    "cluster_name" : var.md_metadata.name_prefix
    "user" : var.md_metadata.name_prefix
  }]
  users = [{
    "name" : var.md_metadata.name_prefix,
    "token" : local.k8s_token
  }]
}

resource "null_resource" "kubectl" {
  count = var.database_configuration.delete_volumes_on_destroy ? 1 : 0
  triggers = {
    #  trigger the null resource with each run so it _also_ runs on destroy
    invokes_me_everytime = uuid()
    namespace            = var.namespace
    name                 = var.md_metadata.name_prefix
    kubeconfig           = sensitive(templatefile("${path.module}/kubeconfig.tpl", { contexts = local.contexts, clusters = local.clusters, users = local.users, colors = false, current_context = local.current_context }))
  }
  provisioner "local-exec" {
    when        = destroy
    command     = <<EOT
      echo "$kubeconfig" > kubeconfig
      export KUBECONFIG=./kubeconfig
      kubectl delete -n $namespace pvc storage-volume-$name-timescaledb-0 wal-volume-$name-timescaledb-0 || true
      rm kubeconfig
EOT
    interpreter = ["/bin/bash", "-c"]
    environment = {
      namespace  = self.triggers.namespace
      name       = self.triggers.name
      kubeconfig = self.triggers.kubeconfig
    }
  }
}
