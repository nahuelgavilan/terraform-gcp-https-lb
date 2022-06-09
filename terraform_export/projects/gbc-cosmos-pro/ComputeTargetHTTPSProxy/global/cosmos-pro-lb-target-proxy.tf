resource "google_compute_target_https_proxy" "cosmos_pro_lb_target_proxy" {
  name             = "cosmos-pro-lb-target-proxy"
  project          = "gbc-cosmos-pro"
  quic_override    = "NONE"
  ssl_certificates = ["https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/sslCertificates/cosmos-cert"]
  url_map          = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/urlMaps/cosmos-pro-lb"
}
# terraform import google_compute_target_https_proxy.cosmos_pro_lb_target_proxy projects/gbc-cosmos-pro/global/targetHttpsProxies/cosmos-pro-lb-target-proxy
