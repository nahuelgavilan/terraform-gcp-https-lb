resource "google_compute_backend_bucket" "empty_bucket" {
  bucket_name = "empty-bucket-pro"
  name        = "empty-bucket"
  project     = "gbc-cosmos-pro"
}
# terraform import google_compute_backend_bucket.empty_bucket projects/gbc-cosmos-pro/global/backendBuckets/empty-bucket
