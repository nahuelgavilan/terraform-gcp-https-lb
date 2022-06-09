resource "google_compute_global_forwarding_rule" "cosmos_frontend" {
  ip_address            = "34.111.241.248"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "cosmos-frontend"
  port_range            = "443-443"
  project               = "gbc-cosmos-pro"
  target                = "https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/global/targetHttpsProxies/cosmos-pro-lb-target-proxy"
}
# terraform import google_compute_global_forwarding_rule.cosmos_frontend projects/gbc-cosmos-pro/global/forwardingRules/cosmos-frontend
