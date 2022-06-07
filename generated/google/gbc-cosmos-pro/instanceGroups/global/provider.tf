provider "google" {
  project = "gbc-cosmos-pro"
}

terraform {
	required_providers {
		google = {
	    version = "~> 4.6.0"
		}
  }
}
