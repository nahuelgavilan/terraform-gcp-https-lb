resource "google_compute_global_forwarding_rule" "cosmos-frontend" {
  ip_address            = var.ip_address
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "cosmos-frontend"
  port_range            = "443-443"
  project               = var.project
  target                = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/targetHttpsProxies/cosmos-pro-lb-target-proxy"
}

resource "google_compute_global_forwarding_rule" "cosmos-frontend-forwarding-rule" {
  ip_address            = var.ip_address
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "cosmos-frontend-forwarding-rule"
  port_range            = "80-80"
  project               = var.project
  target                = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/targetHttpProxies/cosmos-frontend-target-proxy"
}


########################################################################

resource "google_compute_global_forwarding_rule" "tfer--cosmosnet-frontend" {
  ip_address            = "34.149.255.137"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "cosmosnet-frontend"
  port_range            = "443-443"
  project               = "gbc-cosmos-pro"
  target                = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/targetHttpsProxies/cosmosnet-pro-lb-target-proxy"
}

resource "google_compute_global_forwarding_rule" "tfer--cosmosnet-frontend-forwarding-rule" {
  ip_address            = "34.149.255.137"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "cosmosnet-frontend-forwarding-rule"
  port_range            = "80-80"
  project               = "gbc-cosmos-pro"
  target                = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/targetHttpProxies/cosmosnet-frontend-redirect-target-proxy"
}

resource "google_compute_global_forwarding_rule" "tfer--crystal-interop-frontend" {
  ip_address            = "34.149.166.156"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "crystal-interop-frontend"
  port_range            = "443-443"
  project               = "gbc-cosmos-pro"
  target                = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/targetHttpsProxies/crystal-interop-lb-target-proxy"
}

resource "google_compute_global_forwarding_rule" "tfer--crystal-interop-frontend-forwarding-rule" {
  ip_address            = "34.149.166.156"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "crystal-interop-frontend-forwarding-rule"
  port_range            = "80-80"
  project               = "gbc-cosmos-pro"
  target                = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/targetHttpProxies/crystal-interop-frontend-target-proxy"
}
