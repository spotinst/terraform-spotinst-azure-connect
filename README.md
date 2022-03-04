# Connect Azure Subscription To Spot.io Terraform Module

## Introduction
A Terraform module to connect an Azure Subscription to Spot.io

## Details
The module will aid in automatically connecting your Azure Subscription to Spot via terraform. Permissions will be managed by Azure Active Directory with a custom role that will be assigned to the Application. The Terraform module will leverage Spot APIs called via a script to complete the connection to the Spot platform. 

## Example
```hcl
# One or more subscriptions can be added.
provider "azurerm" {
  subscription_id = "redacted"
  features {}
}
provider "azuread" {
  tenant_id = "redacted"
}
#Call the spot module to create a Spot account and link to the first Azure subscription
module "azure-connect" {
  source          = "spotinst/azure-connect/spotinst"
  spotinst_token  = "redacted"
}
output "spot_account_id" {
  value = module.azure-connect.spot_account_id
}
```

### Pre-Reqs
* Spot Organization Admin API token.
* python3 installed
* pip3 installed
* Subscription ID/s
* Azure Active Directory ID
* Azure CLI access with permissions to perform the following actions on each subscription:
  - For Apply:
    - Microsoft.Authorization/roleDefinitions/write
    - Microsoft.Authorization/roleAssignments/write
  - For Destroy:
    - Microsoft.Authorization/roleDefinitions/delete
    - Microsoft.Authorization/roleAssignments/delete


### Apply
The terraform module will do the following:

On Apply:
* Create an App Registration
* Create an App Secret
* Create a Custom Role
* Create a Service Principal 
* Assign Role to Application on Subscription
* Create New Spot Account using the subscription display name
* Provide and link newly created application credentials to Spot account.
