resource "google_compute_url_map" "crystal_interop_frontend_redirect" {
  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }

  description = "Automatically generated HTTP to HTTPS redirect for the crystal-interop-frontend forwarding rule"
  name        = "crystal-interop-frontend-redirect"
  project     = "gbc-cosmos-pro"
}
# terraform import google_compute_url_map.crystal_interop_frontend_redirect projects/gbc-cosmos-pro/global/urlMaps/crystal-interop-frontend-redirect
