locals {
  helm_values = {
    namespace          = var.namespace

    resources = {
      requests = {
        cpu    = "${var.database_configuration.cpu_limit}"
        memory = "${var.database_configuration.memory_limit}Gi"
      }
      limits = {
        cpu    = "${var.database_configuration.cpu_limit}"
        memory = "${var.database_configuration.memory_limit}Gi"
      }
    }

    persistentVolumes = {
      data = {
        size = "${var.database_configuration.data_volume_size}Gi"
      }
    }


    service = {
        primary = {
            labels = var.md_metadata.default_tags
        }
        replica = {
            labels = var.md_metadata.default_tags
        }
    }

    patroni = {
        postgresql = {
            # we'd rather handle the generation of passwords ourselves than let the chart randomly generate them.
            authentication = {
                superuser = {
                    password = random_password.superuser.result
                }
                replication = {
                    password = random_password.replication.result
                }
                # TODO do we need to instantiate an admin or can we just use superuser (postgres)?
                admin = {
                    username = "admin"
                    password = random_password.admin.result
                }
            }
        }
    }
  }
}
