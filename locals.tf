locals {
  cmd               = "${path.module}/scripts/spot-account"
  subscription_name = data.azurerm_subscription.current.display_name
  account_id        = data.external.account.result["account_id"]
  organization_id   = data.external.account.result["organization_id"]
  spotinst_token    = var.debug == true ? nonsensitive(var.spotinst_token) : var.spotinst_token
}

resource "random_string" "value" {
  length = 24
  special = false
}