resource "google_compute_global_address" "cosmosnet_pro_ip" {
  address      = "34.149.255.137"
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
  name         = "cosmosnet-pro-ip"
  project      = "gbc-cosmos-pro"
}
# terraform import google_compute_global_address.cosmosnet_pro_ip projects/gbc-cosmos-pro/global/addresses/cosmosnet-pro-ip
