resource "google_compute_global_forwarding_rule" "crystal_interop_frontend_forwarding_rule" {
  ip_address            = "34.149.166.156"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "crystal-interop-frontend-forwarding-rule"
  port_range            = "80-80"
  project               = "gbc-cosmos-pro"
  target                = "https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/global/targetHttpProxies/crystal-interop-frontend-target-proxy"
}
# terraform import google_compute_global_forwarding_rule.crystal_interop_frontend_forwarding_rule projects/gbc-cosmos-pro/global/forwardingRules/crystal-interop-frontend-forwarding-rule
