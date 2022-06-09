resource "google_compute_target_https_proxy" "crystal_interop_lb_target_proxy" {
  name             = "crystal-interop-lb-target-proxy"
  project          = "gbc-cosmos-pro"
  quic_override    = "NONE"
  ssl_certificates = ["https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/sslCertificates/crystalreport-cosmosgbc-com", "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/sslCertificates/interop-cosmosgbc-com"]
  url_map          = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/urlMaps/crystal-interop-lb"
}
# terraform import google_compute_target_https_proxy.crystal_interop_lb_target_proxy projects/gbc-cosmos-pro/global/targetHttpsProxies/crystal-interop-lb-target-proxy
