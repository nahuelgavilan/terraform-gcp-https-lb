resource "google_compute_disk" "cosmos_9tw8" {
  image                     = "https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/global/images/cosmos-v3"
  name                      = "cosmos-9tw8"
  physical_block_size_bytes = 4096
  project                   = "gbc-cosmos-pro"
  size                      = 50
  type                      = "pd-ssd"
  zone                      = "europe-west1-b"
}
# terraform import google_compute_disk.cosmos_9tw8 projects/gbc-cosmos-pro/zones/europe-west1-b/disks/cosmos-9tw8
