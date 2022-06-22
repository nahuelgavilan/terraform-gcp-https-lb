terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}
provider "google" {
  region  = var.region
  zone    = var.zone
  project = var.project
}