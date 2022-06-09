resource "google_project_service" "file_googleapis_com" {
  project = "289207062865"
  service = "file.googleapis.com"
}
# terraform import google_project_service.file_googleapis_com 289207062865/file.googleapis.com
