resource "google_compute_health_check" "crystalreport_hc" {
  check_interval_sec = 15
  healthy_threshold  = 1
  name               = "crystalreport-hc"
  project            = "gbc-cosmos-pro"

  tcp_health_check {
    port         = 1333
    proxy_header = "NONE"
  }

  timeout_sec         = 5
  unhealthy_threshold = 3
}
# terraform import google_compute_health_check.crystalreport_hc projects/gbc-cosmos-pro/global/healthChecks/crystalreport-hc
