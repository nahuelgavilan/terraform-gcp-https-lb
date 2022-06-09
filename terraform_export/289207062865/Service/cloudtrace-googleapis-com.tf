resource "google_project_service" "cloudtrace_googleapis_com" {
  project = "289207062865"
  service = "cloudtrace.googleapis.com"
}
# terraform import google_project_service.cloudtrace_googleapis_com 289207062865/cloudtrace.googleapis.com
