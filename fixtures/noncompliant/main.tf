terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Intentionally unsafe fixture: CI must reject this configuration.
resource "azurerm_storage_account" "noncompliant_example" {
  name                          = "stpolicyunsafe001"
  resource_group_name           = "rg-policy-example"
  location                      = "eastus"
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  min_tls_version               = "TLS1_0"
  public_network_access_enabled = true
}
