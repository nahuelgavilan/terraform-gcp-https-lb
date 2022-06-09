resource "google_compute_instance_group" "interop" {
  instances = ["https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/zones/europe-west1-b/instances/interop"]
  name      = "interop"

  named_port {
    name = "http"
    port = 1334
  }

  network = "https://www.googleapis.com/compute/beta/projects/grupobc-sharedvpc/global/networks/vpc-shared-core"
  project = "gbc-cosmos-pro"
  zone    = "europe-west1-b"
}
# terraform import google_compute_instance_group.interop projects/gbc-cosmos-pro/zones/europe-west1-b/instanceGroups/interop
