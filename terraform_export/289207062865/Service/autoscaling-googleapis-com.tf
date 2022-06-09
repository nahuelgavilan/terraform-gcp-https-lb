resource "google_project_service" "autoscaling_googleapis_com" {
  project = "289207062865"
  service = "autoscaling.googleapis.com"
}
# terraform import google_project_service.autoscaling_googleapis_com 289207062865/autoscaling.googleapis.com
