## HTTPS LB COSMOS

module "cosmos" {
  source = "./modules/https_lb"

  project = var.project
  name    = "cosmos"
  env     = var.env
  ssl_cert = {
    "cosmos" = ["cosmosprep.cosmosgbc.com", "www.cosmosprep.cosmosgbc.com"]
  }
  hostnames = [["cosmosprep.cosmosgbc.com", "cosmosprep.cosmosgbc.com", "www.cosmosprep.cosmosgbc.com"]]

  backends = {
    "cosmos" = {
      groups = [{
        group = module.cosmosgroup.instance_group
      }]
      health_check = {
        check_interval_sec  = 15
        healthy_threshold   = 5
        port                = 1330
        timeout_sec         = 5
        unhealthy_threshold = 5
      }
      port_name   = "http"
      timeout_sec = 600
    }
  }
}

module "cosmosgroup" {
  source = "./modules/instance_groups"
  zone = "europe-west1-b"
  region = "europe-west1"
  name = "cosmos"
  env = var.env

  named_port = {
    "http" = 1330
  }
  health_check = {
    "cosmos" = {
      check_interval_sec  = 15
      healthy_threshold   = 5
      port                = 1330
      timeout_sec         = 3
      unhealthy_threshold = 4
    }
  }

}