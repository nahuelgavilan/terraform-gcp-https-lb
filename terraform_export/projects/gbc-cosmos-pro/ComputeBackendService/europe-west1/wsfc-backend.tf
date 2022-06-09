resource "google_compute_region_backend_service" "wsfc_backend" {
  connection_draining_timeout_sec = 0
  health_checks                   = ["https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/healthChecks/wsfc-healthcheck"]
  load_balancing_scheme           = "INTERNAL"
  name                            = "wsfc-backend"
  project                         = "gbc-cosmos-pro"
  protocol                        = "TCP"
  region                          = "europe-west1"
  session_affinity                = "NONE"
  timeout_sec                     = 30
}
# terraform import google_compute_region_backend_service.wsfc_backend projects/gbc-cosmos-pro/regions/europe-west1/backendServices/wsfc-backend
