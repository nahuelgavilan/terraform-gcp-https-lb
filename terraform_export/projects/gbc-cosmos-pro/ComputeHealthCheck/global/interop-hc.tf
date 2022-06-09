resource "google_compute_health_check" "interop_hc" {
  check_interval_sec = 15
  healthy_threshold  = 1
  name               = "interop-hc"
  project            = "gbc-cosmos-pro"

  tcp_health_check {
    port         = 1334
    proxy_header = "NONE"
  }

  timeout_sec         = 5
  unhealthy_threshold = 3
}
# terraform import google_compute_health_check.interop_hc projects/gbc-cosmos-pro/global/healthChecks/interop-hc
