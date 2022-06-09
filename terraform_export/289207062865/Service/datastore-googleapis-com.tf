resource "google_project_service" "datastore_googleapis_com" {
  project = "289207062865"
  service = "datastore.googleapis.com"
}
# terraform import google_project_service.datastore_googleapis_com 289207062865/datastore.googleapis.com
