resource "google_storage_bucket" "empty_bucket_pro" {
  force_destroy               = false
  location                    = "EUROPE-WEST1"
  name                        = "empty-bucket-pro"
  project                     = "gbc-cosmos-pro"
  public_access_prevention    = "inherited"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}
# terraform import google_storage_bucket.empty_bucket_pro empty-bucket-pro
