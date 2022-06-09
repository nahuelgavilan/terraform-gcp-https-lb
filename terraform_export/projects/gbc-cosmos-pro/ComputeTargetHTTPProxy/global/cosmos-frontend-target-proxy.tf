resource "google_compute_target_http_proxy" "cosmos_frontend_target_proxy" {
  name    = "cosmos-frontend-target-proxy"
  project = "gbc-cosmos-pro"
  url_map = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/urlMaps/cosmos-frontend-redirect"
}
# terraform import google_compute_target_http_proxy.cosmos_frontend_target_proxy projects/gbc-cosmos-pro/global/targetHttpProxies/cosmos-frontend-target-proxy
