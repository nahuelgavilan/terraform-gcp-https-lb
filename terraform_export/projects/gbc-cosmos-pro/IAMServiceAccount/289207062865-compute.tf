resource "google_service_account" "289207062865_compute" {
  account_id   = "289207062865-compute"
  display_name = "Compute Engine default service account PRO"
  project      = "gbc-cosmos-pro"
}
# terraform import google_service_account.289207062865_compute projects/gbc-cosmos-pro/serviceAccounts/289207062865-compute@gbc-cosmos-pro.iam.gserviceaccount.com
