resource "google_compute_disk" "cosmos_bfjb" {
  image                     = "https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/global/images/cosmos-v3"
  name                      = "cosmos-bfjb"
  physical_block_size_bytes = 4096
  project                   = "gbc-cosmos-pro"
  size                      = 50
  type                      = "pd-ssd"
  zone                      = "europe-west1-b"
}
# terraform import google_compute_disk.cosmos_bfjb projects/gbc-cosmos-pro/zones/europe-west1-b/disks/cosmos-bfjb
