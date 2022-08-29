terraform {
  required_providers {
    kustomization = {
      source  = "kbst/kustomization"
      version = "0.9.0"
    }
  }
}

provider "kustomization" {
  kubeconfig_path = var.kubeconfig_path
}

module "production" {
  source          = "../../../module/app/"
  kubeconfig_path = var.kubeconfig_path
  environment     = "production"
}
