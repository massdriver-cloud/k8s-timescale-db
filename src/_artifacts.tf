locals {

  data_authentication = {
    # TODO maybe this should be admin non postgres superuser ?
    username = "postgres"
    password = random_password.superuser.result
    # TODO validate this is the proper service URL
    hostname = "${local.release}.${var.namespace}.svc.cluster.local"
    port     = 5432
  }

  data_security = {}

  specs_rdbms = {
    engine  = "TimescaleDB"
    # this is the https://github.com/timescale/timescaledb-docker-ha image tag default from the chart
    # contains postgres and timescaledb versions
    version =  "pg14.4-ts2.7.2-p0"
  }
}

resource "massdriver_artifact" "authentication" {
  field                = "postgresql-authentication"
  provider_resource_id = "${local.data_authentication.hostname}"
  name                 = "'Root' postgres user credentials for Timescale DB at for: ${local.data_authentication.hostname}"
  artifact = jsonencode(
    {
      data = {
        infrastructure = {
          kubernetes_service   = local.release
          kubernetes_namespace = var.namespace
        }
        authentication = local.data_authentication
        security = {}
      }
      specs = {
        rdbms = local.specs_rdbms
      }
    }
  )
}