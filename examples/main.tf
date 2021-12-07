provider "azurerm" {
  subscription_id = "redacted"
  features {}
}
provider "azuread" {
  tenant_id = "redacted"
}

#Call the spot module to create a Spot account and link Azure
module "azure-connect" {
  source = "../"
}
output "spot_account_id" {
  value = module.azure-connect.spot_account_id
}

