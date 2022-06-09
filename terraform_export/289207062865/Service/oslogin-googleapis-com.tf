resource "google_project_service" "oslogin_googleapis_com" {
  project = "289207062865"
  service = "oslogin.googleapis.com"
}
# terraform import google_project_service.oslogin_googleapis_com 289207062865/oslogin.googleapis.com
