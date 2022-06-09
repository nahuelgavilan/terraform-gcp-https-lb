resource "google_storage_bucket" "export_cagatntcefo8jdghmoug" {
  force_destroy            = false
  location                 = "US"
  name                     = "export-cagatntcefo8jdghmoug"
  project                  = "gbc-cosmos-pro"
  public_access_prevention = "inherited"
  storage_class            = "STANDARD"
}
# terraform import google_storage_bucket.export_cagatntcefo8jdghmoug export-cagatntcefo8jdghmoug
