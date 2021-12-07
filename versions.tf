terraform {
  required_version = ">= 0.13.0"
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
      version = ">= 2.0.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.85.0"
    }
  }
}