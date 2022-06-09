resource "google_project_service" "storage_googleapis_com" {
  project = "289207062865"
  service = "storage.googleapis.com"
}
# terraform import google_project_service.storage_googleapis_com 289207062865/storage.googleapis.com
