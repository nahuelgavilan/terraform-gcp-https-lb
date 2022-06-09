resource "google_project_service" "serviceusage_googleapis_com" {
  project = "289207062865"
  service = "serviceusage.googleapis.com"
}
# terraform import google_project_service.serviceusage_googleapis_com 289207062865/serviceusage.googleapis.com
