locals {
  data_authentication = {
    username = local.user_super.username
    password = local.user_super.password
    hostname = "${local.release}.${var.namespace}.svc.cluster.local"
    port     = 5432
  }

  data_security = {}

  specs_rdbms = {
    engine  = "TimescaleDB"
    version = local.helm_values.image.tag
  }
}

resource "massdriver_artifact" "authentication" {
  field                = "postgresql-authentication"
  provider_resource_id = local.data_authentication.hostname
  name                 = "'Root' postgres user credentials for Timescale DB at for: ${local.data_authentication.hostname}"
  artifact = jsonencode(
    {
      data = {
        infrastructure = {
          kubernetes_service   = local.release
          kubernetes_namespace = var.namespace
        }
        authentication = local.data_authentication
        security       = local.data_security
      }
      specs = {
        rdbms = local.specs_rdbms
      }
    }
  )
}
