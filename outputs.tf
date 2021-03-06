output "application_id" {
  value = azuread_application.spot.application_id
}
output "subscription_id" {
  value = data.azurerm_subscription.current.subscription_id
}
output "client_secret" {
  value = azuread_application_password.spot-credential.value
}
output "directory_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "spot_account_id" {
  description = "Spot Account ID"
  value = local.account_id
}

output "spot_organization_id" {
  description = "Spot Organization ID"
  value = local.organization_id
}