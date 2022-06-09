resource "google_compute_global_forwarding_rule" "cosmosnet_frontend_forwarding_rule" {
  ip_address            = "34.149.255.137"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "cosmosnet-frontend-forwarding-rule"
  port_range            = "80-80"
  project               = "gbc-cosmos-pro"
  target                = "https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/global/targetHttpProxies/cosmosnet-frontend-redirect-target-proxy"
}
# terraform import google_compute_global_forwarding_rule.cosmosnet_frontend_forwarding_rule projects/gbc-cosmos-pro/global/forwardingRules/cosmosnet-frontend-forwarding-rule
