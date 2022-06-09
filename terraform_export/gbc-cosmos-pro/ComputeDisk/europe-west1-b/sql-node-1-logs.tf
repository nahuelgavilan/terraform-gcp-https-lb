resource "google_compute_disk" "sql_node_1_logs" {
  name                      = "sql-node-1-logs"
  physical_block_size_bytes = 4096
  project                   = "gbc-cosmos-pro"
  size                      = 700
  type                      = "pd-balanced"
  zone                      = "europe-west1-b"
}
# terraform import google_compute_disk.sql_node_1_logs projects/gbc-cosmos-pro/zones/europe-west1-b/disks/sql-node-1-logs
