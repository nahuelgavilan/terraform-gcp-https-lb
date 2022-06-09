resource "google_compute_health_check" "cosmosnet_hc" {
  check_interval_sec = 15
  healthy_threshold  = 2
  name               = "cosmosnet-hc"
  project            = "gbc-cosmos-pro"

  tcp_health_check {
    port         = 1331
    proxy_header = "NONE"
  }

  timeout_sec         = 5
  unhealthy_threshold = 3
}
# terraform import google_compute_health_check.cosmosnet_hc projects/gbc-cosmos-pro/global/healthChecks/cosmosnet-hc
