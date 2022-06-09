resource "google_compute_disk" "sql_node_2" {
  image                     = "https://www.googleapis.com/compute/beta/projects/gbc-cosmos-pro/global/images/sql-image"
  name                      = "sql-node-2"
  physical_block_size_bytes = 4096
  project                   = "gbc-cosmos-pro"
  size                      = 168
  type                      = "pd-balanced"
  zone                      = "europe-west1-d"
}
# terraform import google_compute_disk.sql_node_2 projects/gbc-cosmos-pro/zones/europe-west1-d/disks/sql-node-2
