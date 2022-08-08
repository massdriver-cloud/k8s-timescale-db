terraform {
  required_version = ">= 1.0"
  required_providers {
    massdriver = {
      source  = "massdriver-cloud/massdriver"
      version = "~> 1.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

locals {
  k8s_host                  = var.kubernetes_cluster.data.authentication.cluster.server
  k8s_certificate_authority = base64decode(var.kubernetes_cluster.data.authentication.cluster.certificate-authority-data)
  k8s_token                 = var.kubernetes_cluster.data.authentication.user.token
}

provider "helm" {
  kubernetes {
    host                   = local.k8s_host
    cluster_ca_certificate = local.k8s_certificate_authority
    token                  = local.k8s_token
  }
}