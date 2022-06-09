resource "google_compute_backend_service" "interop_backend" {
  connection_draining_timeout_sec = 300
  health_checks                   = ["https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/healthChecks/interop-hc"]
  load_balancing_scheme           = "EXTERNAL"
  name                            = "interop-backend"
  port_name                       = "http"
  project                         = "gbc-cosmos-pro"
  protocol                        = "HTTP"
  session_affinity                = "CLIENT_IP"
  timeout_sec                     = 120
}
# terraform import google_compute_backend_service.interop_backend projects/gbc-cosmos-pro/global/backendServices/interop-backend
