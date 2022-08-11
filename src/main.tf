locals {
  // Note, to anyone looking to update this chart version, timescale doesn't maintain github tags / releases
  // so the best way to find the the latest version is to use the latest tag from the chart repo.
  // there's a long history of people being confused by this https://github.com/timescale/helm-charts/issues/324 https://github.com/timescale/helm-charts/issues/322 https://github.com/timescale/helm-charts/issues/299
  /* 
  ```bash
  helm repo add timescale 'https://charts.timescale.com'
  helm repo update
  helm show chart timescale/timescaledb-single | grep version
  ```
  */ 
  chart_version = "0.14.0"
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
  repository       = "https://charts.timescale.com"
  version          = local.chart_version
  namespace        = var.namespace
  create_namespace = true

  values = [
    "${file("${path.module}/values.yaml")}",
    yamlencode(local.helm_values)
  ]
}