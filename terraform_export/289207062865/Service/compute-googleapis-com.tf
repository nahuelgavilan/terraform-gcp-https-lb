resource "google_project_service" "compute_googleapis_com" {
  project = "289207062865"
  service = "compute.googleapis.com"
}
# terraform import google_project_service.compute_googleapis_com 289207062865/compute.googleapis.com
