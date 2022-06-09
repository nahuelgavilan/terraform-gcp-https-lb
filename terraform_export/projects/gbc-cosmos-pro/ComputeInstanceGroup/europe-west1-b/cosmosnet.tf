resource "google_compute_instance_group" "cosmosnet" {
  description = "This instance group is controlled by Instance Group Manager 'cosmosnet'. To modify instances in this group, use the Instance Group Manager API: https://cloud.google.com/compute/docs/reference/latest/instanceGroupManagers"
  instances   = ["https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/zones/europe-west1-b/instances/cosmosnet-fr6v", "https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/zones/europe-west1-b/instances/cosmosnet-jm23"]
  name        = "cosmosnet"

  named_port {
    name = "port-1331"
    port = 1331
  }

  named_port {
    name = "port-1332"
    port = 1332
  }

  network = "https://www.googleapis.com/compute/beta/projects/grupobc-sharedvpc/global/networks/vpc-shared-core"
  project = "gbc-cosmos-pro"
  zone    = "europe-west1-b"
}
# terraform import google_compute_instance_group.cosmosnet projects/gbc-cosmos-pro/zones/europe-west1-b/instanceGroups/cosmosnet
