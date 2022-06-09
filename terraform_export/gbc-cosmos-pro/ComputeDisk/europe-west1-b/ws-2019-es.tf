resource "google_compute_disk" "ws_2019_es" {
  image                     = "https://www.googleapis.com/compute/beta/projects/windows-cloud/global/images/windows-server-2019-dc-v20220314"
  name                      = "ws-2019-es"
  physical_block_size_bytes = 4096
  project                   = "gbc-cosmos-pro"
  size                      = 50
  type                      = "pd-ssd"
  zone                      = "europe-west1-b"
}
# terraform import google_compute_disk.ws_2019_es projects/gbc-cosmos-pro/zones/europe-west1-b/disks/ws-2019-es
