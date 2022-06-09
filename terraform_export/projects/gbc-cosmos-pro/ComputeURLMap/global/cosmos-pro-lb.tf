resource "google_compute_url_map" "cosmos_pro_lb" {
  default_service = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/backendBuckets/empty-bucket"

  host_rule {
    hosts        = ["cosmos.cosmosgbc.com", "www.cosmos.cosmosgbc.com"]
    path_matcher = "path-matcher-1"
  }

  name = "cosmos-pro-lb"

  path_matcher {
    default_service = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/backendServices/cosmos-pro-backend"
    name            = "path-matcher-1"
  }

  project = "gbc-cosmos-pro"
}
# terraform import google_compute_url_map.cosmos_pro_lb projects/gbc-cosmos-pro/global/urlMaps/cosmos-pro-lb
