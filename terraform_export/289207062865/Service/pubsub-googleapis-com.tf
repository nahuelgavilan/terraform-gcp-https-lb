resource "google_project_service" "pubsub_googleapis_com" {
  project = "289207062865"
  service = "pubsub.googleapis.com"
}
# terraform import google_project_service.pubsub_googleapis_com 289207062865/pubsub.googleapis.com
