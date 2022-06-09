resource "google_compute_global_address" "crystal_interop_ip" {
  address      = "34.149.166.156"
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
  name         = "crystal-interop-ip"
  project      = "gbc-cosmos-pro"
}
# terraform import google_compute_global_address.crystal_interop_ip projects/gbc-cosmos-pro/global/addresses/crystal-interop-ip
