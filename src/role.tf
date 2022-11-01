# https://github.com/timescale/helm-charts/issues/405
resource "kubernetes_role" "patch_timescaledb" {
  metadata {
    name      = var.md_metadata.name_prefix
    namespace = var.namespace
    labels    = var.md_metadata.default_tags
  }

  rule {
    api_groups = [""]
    resources  = ["services"]
    verbs      = ["create"]
  }
}

resource "kubernetes_role_binding" "patch_timescaledb" {
  metadata {
    name      = var.md_metadata.name_prefix
    namespace = var.namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = var.md_metadata.name_prefix
  }

  subject {
    kind      = "ServiceAccount"
    name      = var.md_metadata.name_prefix
    namespace = var.namespace
  }
  depends_on = [
    kubernetes_role.patch_timescaledb
  ]
}
