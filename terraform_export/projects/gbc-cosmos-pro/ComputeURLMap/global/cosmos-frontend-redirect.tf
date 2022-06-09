resource "google_compute_url_map" "cosmos_frontend_redirect" {
  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }

  description = "Automatically generated HTTP to HTTPS redirect for the cosmos-frontend forwarding rule"
  name        = "cosmos-frontend-redirect"
  project     = "gbc-cosmos-pro"
}
# terraform import google_compute_url_map.cosmos_frontend_redirect projects/gbc-cosmos-pro/global/urlMaps/cosmos-frontend-redirect
