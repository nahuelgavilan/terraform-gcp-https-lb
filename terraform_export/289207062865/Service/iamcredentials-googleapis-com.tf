resource "google_project_service" "iamcredentials_googleapis_com" {
  project = "289207062865"
  service = "iamcredentials.googleapis.com"
}
# terraform import google_project_service.iamcredentials_googleapis_com 289207062865/iamcredentials.googleapis.com
