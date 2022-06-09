resource "google_compute_health_check" "wsfc_healthcheck" {
  check_interval_sec = 2
  healthy_threshold  = 1
  name               = "wsfc-healthcheck"
  project            = "gbc-cosmos-pro"

  tcp_health_check {
    port               = 59997
    port_specification = "USE_FIXED_PORT"
    proxy_header       = "NONE"
  }

  timeout_sec         = 1
  unhealthy_threshold = 2
}
# terraform import google_compute_health_check.wsfc_healthcheck projects/gbc-cosmos-pro/global/healthChecks/wsfc-healthcheck
