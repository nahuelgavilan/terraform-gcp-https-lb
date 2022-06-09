resource "google_compute_instance_group" "cosmos" {
  description = "This instance group is controlled by Instance Group Manager 'cosmos'. To modify instances in this group, use the Instance Group Manager API: https://cloud.google.com/compute/docs/reference/latest/instanceGroupManagers"
  instances   = ["https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/zones/europe-west1-b/instances/cosmos-9tw8", "https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/zones/europe-west1-b/instances/cosmos-bfjb"]
  name        = "cosmos"

  named_port {
    name = "http"
    port = 1330
  }

  network = "https://www.googleapis.com/compute/beta/projects/grupobc-sharedvpc/global/networks/vpc-shared-core"
  project = "gbc-cosmos-pro"
  zone    = "europe-west1-b"
}
# terraform import google_compute_instance_group.cosmos projects/gbc-cosmos-pro/zones/europe-west1-b/instanceGroups/cosmos
