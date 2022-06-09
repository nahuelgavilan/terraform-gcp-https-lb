resource "google_project_service" "bigquerystorage_googleapis_com" {
  project = "289207062865"
  service = "bigquerystorage.googleapis.com"
}
# terraform import google_project_service.bigquerystorage_googleapis_com 289207062865/bigquerystorage.googleapis.com
