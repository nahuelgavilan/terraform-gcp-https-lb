resource "google_project_service" "bigquery_googleapis_com" {
  project = "289207062865"
  service = "bigquery.googleapis.com"
}
# terraform import google_project_service.bigquery_googleapis_com 289207062865/bigquery.googleapis.com
