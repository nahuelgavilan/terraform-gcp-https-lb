resource "google_compute_region_health_check" "sql_healthcheck" {
  check_interval_sec = 5
  healthy_threshold  = 2
  name               = "sql-healthcheck"
  project            = "gbc-cosmos-pro"
  region             = "europe-west1"

  tcp_health_check {
    port         = 1433
    proxy_header = "NONE"
  }

  timeout_sec         = 5
  unhealthy_threshold = 2
}
# terraform import google_compute_region_health_check.sql_healthcheck projects/gbc-cosmos-pro/regions/europe-west1/healthChecks/sql-healthcheck
