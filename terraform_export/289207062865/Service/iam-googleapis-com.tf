resource "google_project_service" "iam_googleapis_com" {
  project = "289207062865"
  service = "iam.googleapis.com"
}
# terraform import google_project_service.iam_googleapis_com 289207062865/iam.googleapis.com
