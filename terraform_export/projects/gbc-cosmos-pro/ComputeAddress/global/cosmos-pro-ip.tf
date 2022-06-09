resource "google_compute_global_address" "cosmos_pro_ip" {
  address      = "34.111.241.248"
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
  name         = "cosmos-pro-ip"
  project      = "gbc-cosmos-pro"
}
# terraform import google_compute_global_address.cosmos_pro_ip projects/gbc-cosmos-pro/global/addresses/cosmos-pro-ip
