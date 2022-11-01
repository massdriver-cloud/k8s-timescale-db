locals {
  user_super = {
    username = "postgres"
    password = random_password.superuser.result
  }
}

resource "random_password" "superuser" {
  length  = 16
  special = false
}
