locals {
  chart_version = "0.8.2"
  release       = var.md_metadata.name_prefix
}

resource "random_password" "superuser" {
  length  = 16
  special = false
}

resource "random_password" "admin" {
  length  = 16
  special = false
}

resource "random_password" "replication" {
  length  = 16
  special = false
}

resource "helm_release" "timescaledb" {
  name             = local.release
  chart            = "timescaledb-single"
  repository       = "https://raw.githubusercontent.com/timescale/timescaledb-kubernetes/master/charts/repo/"
  version          = local.chart_version
  namespace        = var.namespace
  create_namespace = true

  values = [
    "${file("${path.module}/values.yaml")}",
    yamlencode(local.helm_values)
  ]
}