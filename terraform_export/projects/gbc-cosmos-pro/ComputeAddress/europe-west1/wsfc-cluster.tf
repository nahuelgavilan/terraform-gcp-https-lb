resource "google_compute_address" "wsfc_cluster" {
  address      = "192.168.110.37"
  address_type = "INTERNAL"
  name         = "wsfc-cluster"
  network_tier = "PREMIUM"
  project      = "gbc-cosmos-pro"
  purpose      = "GCE_ENDPOINT"
  region       = "europe-west1"
  subnetwork   = "https://www.googleapis.com/compute/v1/projects/grupobc-sharedvpc/regions/europe-west1/subnetworks/sub-shared-cosmos-pro"
}
# terraform import google_compute_address.wsfc_cluster projects/gbc-cosmos-pro/regions/europe-west1/addresses/wsfc-cluster
