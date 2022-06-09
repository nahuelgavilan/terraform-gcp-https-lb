resource "google_compute_url_map" "cosmosnet_pro_lb" {
  default_service = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/backendBuckets/empty-bucket"

  host_rule {
    hosts        = ["cosmosnet.cosmosgbc.com", "www.cosmosnet.cosmosgbc.com"]
    path_matcher = "path-matcher-1"
  }

  host_rule {
    hosts        = ["webservices.cosmosgbc.com", "www.webservices.cosmosgbc.com"]
    path_matcher = "path-matcher-2"
  }

  name = "cosmosnet-pro-lb"

  path_matcher {
    default_service = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/backendServices/cosmosnet-pro-backend"
    name            = "path-matcher-1"
  }

  path_matcher {
    default_service = "https://www.googleapis.com/compute/v1/projects/gbc-cosmos-pro/global/backendServices/ws-pro-backend"
    name            = "path-matcher-2"
  }

  project = "gbc-cosmos-pro"
}
# terraform import google_compute_url_map.cosmosnet_pro_lb projects/gbc-cosmos-pro/global/urlMaps/cosmosnet-pro-lb
