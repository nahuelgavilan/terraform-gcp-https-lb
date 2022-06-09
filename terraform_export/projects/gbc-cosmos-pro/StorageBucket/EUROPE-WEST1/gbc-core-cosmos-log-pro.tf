resource "google_storage_bucket" "gbc_core_cosmos_log_pro" {
  force_destroy = false

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      age        = 30
      with_state = "ANY"
    }
  }

  location                    = "EUROPE-WEST1"
  name                        = "gbc-core-cosmos-log-pro"
  project                     = "gbc-cosmos-pro"
  public_access_prevention    = "inherited"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}
# terraform import google_storage_bucket.gbc_core_cosmos_log_pro gbc-core-cosmos-log-pro
