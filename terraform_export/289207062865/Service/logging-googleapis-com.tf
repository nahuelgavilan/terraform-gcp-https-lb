resource "google_project_service" "logging_googleapis_com" {
  project = "289207062865"
  service = "logging.googleapis.com"
}
# terraform import google_project_service.logging_googleapis_com 289207062865/logging.googleapis.com
