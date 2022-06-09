resource "google_compute_backend_service" "ws_pro_backend" {
  connection_draining_timeout_sec = 300
  health_checks                   = ["https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/healthChecks/cosmosnet-hc-1332"]
  load_balancing_scheme           = "EXTERNAL"
  name                            = "ws-pro-backend"
  port_name                       = "port-1332"
  project                         = "gbc-cosmos-pro"
  protocol                        = "HTTP"
  session_affinity                = "CLIENT_IP"
  timeout_sec                     = 600
}
# terraform import google_compute_backend_service.ws_pro_backend projects/gbc-cosmos-pro/global/backendServices/ws-pro-backend
