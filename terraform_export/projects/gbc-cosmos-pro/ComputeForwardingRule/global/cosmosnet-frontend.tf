resource "google_compute_global_forwarding_rule" "cosmosnet_frontend" {
  ip_address            = "34.149.255.137"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "cosmosnet-frontend"
  port_range            = "443-443"
  project               = "gbc-cosmos-pro"
  target                = "https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/global/targetHttpsProxies/cosmosnet-pro-lb-target-proxy"
}
# terraform import google_compute_global_forwarding_rule.cosmosnet_frontend projects/gbc-cosmos-pro/global/forwardingRules/cosmosnet-frontend
