resource "google_compute_instance_group" "wsfc_group_1" {
  instances = ["https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/zones/europe-west1-b/instances/sql-node-1"]
  name      = "wsfc-group-1"
  network   = "https://www.googleapis.com/compute/beta/projects/grupobc-sharedvpc/global/networks/vpc-shared-core"
  project   = "gbc-cosmos-pro"
  zone      = "europe-west1-b"
}
# terraform import google_compute_instance_group.wsfc_group_1 projects/gbc-cosmos-pro/zones/europe-west1-b/instanceGroups/wsfc-group-1
