terraform {
  required_providers {
    kustomization = {
      source  = "kbst/kustomization"
      version = "0.9.0"
    }
  }
}

provider "kustomization" {
  kubeconfig_path = "~/.kube/config"
  context         = var.context
}

data "kustomization" "environment" {
  provider = kustomization
  path     = "${path.module}/../../manifest/overlays/${var.environment}"
}

resource "kustomization_resource" "environment" {
  provider = kustomization
  for_each = data.kustomization.environment.ids
  manifest = data.kustomization.environment.manifests[each.value]
}
