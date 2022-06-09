resource "google_compute_url_map" "cosmosnet_frontend_redirect" {
  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }

  name    = "cosmosnet-frontend-redirect"
  project = "gbc-cosmos-pro"
}
# terraform import google_compute_url_map.cosmosnet_frontend_redirect projects/gbc-cosmos-pro/global/urlMaps/cosmosnet-frontend-redirect
