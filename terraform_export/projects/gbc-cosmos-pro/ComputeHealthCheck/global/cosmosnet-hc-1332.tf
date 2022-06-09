resource "google_compute_health_check" "cosmosnet_hc_1332" {
  check_interval_sec = 15
  healthy_threshold  = 3
  name               = "cosmosnet-hc-1332"
  project            = "gbc-cosmos-pro"

  tcp_health_check {
    port         = 1332
    proxy_header = "NONE"
  }

  timeout_sec         = 5
  unhealthy_threshold = 1
}
# terraform import google_compute_health_check.cosmosnet_hc_1332 projects/gbc-cosmos-pro/global/healthChecks/cosmosnet-hc-1332
