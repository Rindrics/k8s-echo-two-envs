terraform {
  required_providers {
    kind = {
      source  = "justenwalker/kind"
      version = "0.11.0-rc.1"
    }
  }
}

resource "kind_cluster" "new" {
  name   = "production"
  config = file("${path.module}/cluster_config.tftpl")
}
