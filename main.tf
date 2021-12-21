resource "azuread_application" "spot" {
  display_name                = "Spot.io-${data.azurerm_subscription.current.display_name}"
  web {
    homepage_url = "https://spot.io"
  }
}

resource "azuread_application_password" "spot-credential" {
  depends_on            = [azuread_application.spot]
  application_object_id = azuread_application.spot.id
  end_date              = var.end_date
}

resource "azurerm_role_definition" "spot" {
  name        = "Spot.io-custom-role-${data.azurerm_subscription.current.display_name}-${random_string.value.result}"
  provisioner "local-exec" {
    # Without this set-cloud-credentials fails
    command = "sleep 10"
  }
  scope       = data.azurerm_subscription.current.id
  description = "This is a custom role created via Terraform for Spot.io App"

  permissions {
    actions = var.actions
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.current.id
  ]
}

resource "azuread_service_principal" "spot" {
  depends_on           = [azuread_application.spot]
  application_id       = azuread_application.spot.application_id
}

resource "azurerm_role_assignment" "spot" {
  scope                = data.azurerm_subscription.current.id
  role_definition_id   = azurerm_role_definition.spot.role_definition_resource_id
  principal_id         = azuread_service_principal.spot.object_id
}

# Call Spot API to create the Spot Account
resource "null_resource" "account" {
  triggers = {
    cmd = "${path.module}/scripts/spot-account-azure"
    name = data.azurerm_subscription.current.display_name
  }
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command = "${self.triggers.cmd} create \"${self.triggers.name}\""
  }

  provisioner "local-exec" {
    when = destroy
    interpreter = ["/bin/bash", "-c"]
    command = <<-EOT
            ID=$(${self.triggers.cmd} get --filter=name="${self.triggers.name}" --attr=account_id) &&\
            ${self.triggers.cmd} delete "$ID"
        EOT
  }
}


# Link the Role ARN to the Spot Account
resource "null_resource" "account_association" {
  depends_on = [azurerm_role_assignment.spot, null_resource.account]
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command = "${local.cmd} set-cloud-credentials --account-id ${local.account_id} --client-id ${azuread_application.spot.application_id} --client-secret ${azuread_application_password.spot-credential.value} --tenant-id ${data.azurerm_client_config.current.tenant_id} --subscription-id ${data.azurerm_subscription.current.subscription_id}"
  }
}

