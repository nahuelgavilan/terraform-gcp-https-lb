resource "google_compute_disk" "sql_node_1_data" {
  name                      = "sql-node-1-data"
  physical_block_size_bytes = 4096
  project                   = "gbc-cosmos-pro"
  size                      = 800
  type                      = "pd-balanced"
  zone                      = "europe-west1-b"
}
# terraform import google_compute_disk.sql_node_1_data projects/gbc-cosmos-pro/zones/europe-west1-b/disks/sql-node-1-data
