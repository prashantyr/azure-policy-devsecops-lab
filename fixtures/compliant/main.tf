terraform {
  required_version = ">= 1.6.0"
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

resource "azurerm_storage_account" "compliant_example" {
  name                          = "stpolicyexample001"
  resource_group_name           = "rg-policy-example"
  location                      = "eastus"
  account_tier                  = "Standard"
  account_replication_type      = "ZRS"
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = false

  blob_properties {
    versioning_enabled = true
    delete_retention_policy {
      days = 7
    }
  }
}
