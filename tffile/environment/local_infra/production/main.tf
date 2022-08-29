terraform {
  required_providers {
    kind = {
      source  = "justenwalker/kind"
      version = "0.11.0-rc.1"
    }
  }
}

module "kind_prd_cluster" {
  source                 = "../../../module/local_infra/"
  environment            = "production"
  host_ingress_port_http = 80
  host_ingress_port_ssh  = 443
}
