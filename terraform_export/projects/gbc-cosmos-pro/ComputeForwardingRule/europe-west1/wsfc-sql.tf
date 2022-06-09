resource "google_compute_forwarding_rule" "wsfc_sql" {
  backend_service       = "https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/regions/europe-west1/backendServices/wsfc-backend"
  ip_address            = "192.168.110.36"
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL"
  name                  = "wsfc-sql"
  network               = "https://www.googleapis.com/compute/beta/projects/grupobc-sharedvpc/global/networks/vpc-shared-core"
  network_tier          = "PREMIUM"
  ports                 = ["1433"]
  project               = "gbc-cosmos-pro"
  region                = "europe-west1"
  subnetwork            = "https://www.googleapis.com/compute/beta/projects/grupobc-sharedvpc/regions/europe-west1/subnetworks/sub-shared-cosmos-pro"
}
# terraform import google_compute_forwarding_rule.wsfc_sql projects/gbc-cosmos-pro/regions/europe-west1/forwardingRules/wsfc-sql
