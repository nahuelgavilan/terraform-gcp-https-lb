resource "google_compute_target_https_proxy" "cosmosnet_pro_lb_target_proxy" {
  name             = "cosmosnet-pro-lb-target-proxy"
  project          = "gbc-cosmos-pro"
  quic_override    = "NONE"
  ssl_certificates = ["https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/sslCertificates/cosmosnet-cosmosgbc-com", "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/sslCertificates/webservices-cosmosgbc-com"]
  url_map          = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/urlMaps/cosmosnet-pro-lb"
}
# terraform import google_compute_target_https_proxy.cosmosnet_pro_lb_target_proxy projects/gbc-cosmos-pro/global/targetHttpsProxies/cosmosnet-pro-lb-target-proxy
