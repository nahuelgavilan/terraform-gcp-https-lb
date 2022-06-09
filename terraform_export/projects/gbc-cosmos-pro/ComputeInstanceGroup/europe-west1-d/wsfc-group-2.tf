resource "google_compute_instance_group" "wsfc_group_2" {
  instances = ["https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/zones/europe-west1-d/instances/sql-node-2"]
  name      = "wsfc-group-2"
  network   = "https://www.googleapis.com/compute/beta/projects/grupobc-sharedvpc/global/networks/vpc-shared-core"
  project   = "gbc-cosmos-pro"
  zone      = "europe-west1-d"
}
# terraform import google_compute_instance_group.wsfc_group_2 projects/gbc-cosmos-pro/zones/europe-west1-d/instanceGroups/wsfc-group-2
