resource "google_compute_disk" "sql_node_2_logs" {
  name                      = "sql-node-2-logs"
  physical_block_size_bytes = 4096
  project                   = "gbc-cosmos-pro"
  size                      = 700
  type                      = "pd-balanced"
  zone                      = "europe-west1-d"
}
# terraform import google_compute_disk.sql_node_2_logs projects/gbc-cosmos-pro/zones/europe-west1-d/disks/sql-node-2-logs
