resource "google_project_service" "cloudapis_googleapis_com" {
  project = "289207062865"
  service = "cloudapis.googleapis.com"
}
# terraform import google_project_service.cloudapis_googleapis_com 289207062865/cloudapis.googleapis.com
