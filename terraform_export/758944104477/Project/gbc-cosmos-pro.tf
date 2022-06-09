resource "google_project" "gbc_cosmos_pro" {
  auto_create_network = true
  billing_account     = "01EAA8-6E97F8-547B86"
  name                = "gbc-cosmos-pro"
  org_id              = "758944104477"
  project_id          = "gbc-cosmos-pro"
}
# terraform import google_project.gbc_cosmos_pro projects/gbc-cosmos-pro
