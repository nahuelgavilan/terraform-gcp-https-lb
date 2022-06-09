resource "google_project_service" "container_googleapis_com" {
  project = "289207062865"
  service = "container.googleapis.com"
}
# terraform import google_project_service.container_googleapis_com 289207062865/container.googleapis.com
