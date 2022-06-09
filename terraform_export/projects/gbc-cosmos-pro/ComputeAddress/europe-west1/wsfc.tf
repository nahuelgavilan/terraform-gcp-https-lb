resource "google_compute_address" "wsfc" {
  address      = "192.168.110.36"
  address_type = "INTERNAL"
  name         = "wsfc"
  network_tier = "PREMIUM"
  project      = "gbc-cosmos-pro"
  purpose      = "GCE_ENDPOINT"
  region       = "europe-west1"
  subnetwork   = "https://www.googleapis.com/compute/v1/projects/grupobc-sharedvpc/regions/europe-west1/subnetworks/sub-shared-cosmos-pro"
}
# terraform import google_compute_address.wsfc projects/gbc-cosmos-pro/regions/europe-west1/addresses/wsfc
