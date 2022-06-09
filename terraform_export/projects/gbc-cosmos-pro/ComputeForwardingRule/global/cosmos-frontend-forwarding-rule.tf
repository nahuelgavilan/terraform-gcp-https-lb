resource "google_compute_global_forwarding_rule" "cosmos_frontend_forwarding_rule" {
  ip_address            = "34.111.241.248"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "cosmos-frontend-forwarding-rule"
  port_range            = "80-80"
  project               = "gbc-cosmos-pro"
  target                = "https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/global/targetHttpProxies/cosmos-frontend-target-proxy"
}
# terraform import google_compute_global_forwarding_rule.cosmos_frontend_forwarding_rule projects/gbc-cosmos-pro/global/forwardingRules/cosmos-frontend-forwarding-rule
