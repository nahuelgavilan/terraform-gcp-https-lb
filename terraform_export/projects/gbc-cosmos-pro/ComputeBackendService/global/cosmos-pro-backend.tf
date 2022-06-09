resource "google_compute_backend_service" "cosmos_pro_backend" {
  connection_draining_timeout_sec = 300
  health_checks                   = ["https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/healthChecks/cosmos-hc"]
  load_balancing_scheme           = "EXTERNAL"
  name                            = "cosmos-pro-backend"
  port_name                       = "http"
  project                         = "gbc-cosmos-pro"
  protocol                        = "HTTP"
  session_affinity                = "CLIENT_IP"
  timeout_sec                     = 600
}
# terraform import google_compute_backend_service.cosmos_pro_backend projects/gbc-cosmos-pro/global/backendServices/cosmos-pro-backend
