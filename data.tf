data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}
data "azuread_client_config" "current" {}

# Retrieve the Spot Account ID Information
data "external" "account" {
  depends_on = [null_resource.account]
  program = [
    local.cmd,
    "get",
    "--filter=name=${local.subscription_name}",
    "--token=${local.spotinst_token}"
  ]
}
