resource "google_project_service" "storage_api_googleapis_com" {
  project = "289207062865"
  service = "storage-api.googleapis.com"
}
# terraform import google_project_service.storage_api_googleapis_com 289207062865/storage-api.googleapis.com
