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
  environment            = "development"
  host_ingress_port_http = 8080
  host_ingress_port_ssh  = 8443
}
