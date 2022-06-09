resource "google_compute_disk" "cosmosnet_fr6v" {
  image                     = "https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/global/images/cosmosnet-pro"
  name                      = "cosmosnet-fr6v"
  physical_block_size_bytes = 4096
  project                   = "gbc-cosmos-pro"
  size                      = 50
  type                      = "pd-ssd"
  zone                      = "europe-west1-b"
}
# terraform import google_compute_disk.cosmosnet_fr6v projects/gbc-cosmos-pro/zones/europe-west1-b/disks/cosmosnet-fr6v
