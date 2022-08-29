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
}

module "development" {
  source      = "../../../module/app/"
  context     = var.context
  environment = "development"
}
