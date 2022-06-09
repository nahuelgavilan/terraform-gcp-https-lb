resource "google_compute_disk" "sql_witness" {
  image                     = "https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/global/images/ws-base"
  name                      = "sql-witness"
  physical_block_size_bytes = 4096
  project                   = "gbc-cosmos-pro"
  size                      = 50
  type                      = "pd-balanced"
  zone                      = "europe-west1-c"
}
# terraform import google_compute_disk.sql_witness projects/gbc-cosmos-pro/zones/europe-west1-c/disks/sql-witness
