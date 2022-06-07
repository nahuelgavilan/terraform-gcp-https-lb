data "terraform_remote_state" "instanceTemplates" {
  backend = "local"

  config = {
    path = "../../../../../generated/google/gbc-cosmos-pro/instanceTemplates/global/terraform.tfstate"
  }
}
