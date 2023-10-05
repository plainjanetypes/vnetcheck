#create a storage account

resource "azurerm_storage_account" "cusstrg" {
  name= "cusstrg"
  location = "eastus"
  resource_group_name = azurerm_resource_group.resgrp.name
  access_tier = "Hot"
  account_replication_type = "LRS"
  account_tier = "Standard"
}