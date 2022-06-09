resource "google_compute_global_forwarding_rule" "crystal_interop_frontend" {
  ip_address            = "34.149.166.156"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "crystal-interop-frontend"
  port_range            = "443-443"
  project               = "gbc-cosmos-pro"
  target                = "https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/global/targetHttpsProxies/crystal-interop-lb-target-proxy"
}
# terraform import google_compute_global_forwarding_rule.crystal_interop_frontend projects/gbc-cosmos-pro/global/forwardingRules/crystal-interop-frontend
