resource "google_compute_target_http_proxy" "cosmosnet_frontend_redirect_target_proxy" {
  name    = "cosmosnet-frontend-redirect-target-proxy"
  project = "gbc-cosmos-pro"
  url_map = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/urlMaps/cosmosnet-frontend-redirect"
}
# terraform import google_compute_target_http_proxy.cosmosnet_frontend_redirect_target_proxy projects/gbc-cosmos-pro/global/targetHttpProxies/cosmosnet-frontend-redirect-target-proxy
