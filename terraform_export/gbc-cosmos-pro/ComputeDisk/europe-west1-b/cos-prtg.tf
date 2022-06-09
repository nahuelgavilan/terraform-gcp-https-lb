resource "google_compute_disk" "cos_prtg" {
  image                     = "https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/global/images/ws-base"
  name                      = "cos-prtg"
  physical_block_size_bytes = 4096
  project                   = "gbc-cosmos-pro"
  size                      = 80
  type                      = "pd-balanced"
  zone                      = "europe-west1-b"
}
# terraform import google_compute_disk.cos_prtg projects/gbc-cosmos-pro/zones/europe-west1-b/disks/cos-prtg
