resource "google_service_account" "get_ip_pro" {
  account_id   = "get-ip-pro"
  display_name = "get-ip-pro"
  project      = "gbc-cosmos-pro"
}
# terraform import google_service_account.get_ip_pro projects/gbc-cosmos-pro/serviceAccounts/get-ip-pro@gbc-cosmos-pro.iam.gserviceaccount.com
