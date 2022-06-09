resource "google_compute_target_http_proxy" "crystal_interop_frontend_target_proxy" {
  name    = "crystal-interop-frontend-target-proxy"
  project = "gbc-cosmos-pro"
  url_map = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/urlMaps/crystal-interop-frontend-redirect"
}
# terraform import google_compute_target_http_proxy.crystal_interop_frontend_target_proxy projects/gbc-cosmos-pro/global/targetHttpProxies/crystal-interop-frontend-target-proxy
