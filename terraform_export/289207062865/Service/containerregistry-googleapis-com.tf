resource "google_project_service" "containerregistry_googleapis_com" {
  project = "289207062865"
  service = "containerregistry.googleapis.com"
}
# terraform import google_project_service.containerregistry_googleapis_com 289207062865/containerregistry.googleapis.com
