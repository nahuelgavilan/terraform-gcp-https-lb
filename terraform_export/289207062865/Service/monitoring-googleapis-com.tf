resource "google_project_service" "monitoring_googleapis_com" {
  project = "289207062865"
  service = "monitoring.googleapis.com"
}
# terraform import google_project_service.monitoring_googleapis_com 289207062865/monitoring.googleapis.com
