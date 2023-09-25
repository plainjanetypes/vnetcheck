terraform {
  #version = ">0.14"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=2.0.0"  #all throughout code if many blocks use the same provider
    }
    external = {
      source = "hashicorp/external"
    }
  }
  #store state in terra general for M01-M03
    backend "azurerm" {
    resource_group_name = "generalrg"
    storage_account_name = "terrageneral"
    container_name = "tfbackup"
    key = "M01-VDES-03-ER-ddos.tfstate"
    #service_connection_id = ""
    #org_service_url =
    #project_name =
    }
}

provider "azurerm" {
  #version = ">=2.0.0"
  features {}

  client_id = 
  client_secret = 
  tenant_id = 
  subscription_id = 
}
#adding provider for external powershell source from https://registry.terraform.io/providers/hashicorp/external/latest
provider "external" {
    #no version limit
}
/*
#adding for data reference
data "azurerm_client_config" "current" {} */