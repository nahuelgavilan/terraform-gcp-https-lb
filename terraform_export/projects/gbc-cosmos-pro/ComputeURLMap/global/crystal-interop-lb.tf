resource "google_compute_url_map" "crystal_interop_lb" {
  default_service = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/backendBuckets/empty-bucket"

  host_rule {
    hosts        = ["crystalreport.cosmosgbc.com", "www.crystalreport.cosmosgbc.com"]
    path_matcher = "path-matcher-1"
  }

  host_rule {
    hosts        = ["interop.cosmosgbc.com", "www.interop.cosmosgbc.com"]
    path_matcher = "path-matcher-2"
  }

  name = "crystal-interop-lb"

  path_matcher {
    default_service = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/backendServices/crystalreport-backend"
    name            = "path-matcher-1"
  }

  path_matcher {
    default_service = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/backendServices/interop-backend"
    name            = "path-matcher-2"
  }

  project = "gbc-cosmos-pro"
}
# terraform import google_compute_url_map.crystal_interop_lb projects/gbc-cosmos-pro/global/urlMaps/crystal-interop-lb
