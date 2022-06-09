resource "google_project_service" "servicemanagement_googleapis_com" {
  project = "289207062865"
  service = "servicemanagement.googleapis.com"
}
# terraform import google_project_service.servicemanagement_googleapis_com 289207062865/servicemanagement.googleapis.com
