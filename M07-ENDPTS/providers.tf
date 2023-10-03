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
}

provider "azurerm" {
  #version = ">=2.0.0"
  features {}
}
#adding provider for external powershell source from https://registry.terraform.io/providers/hashicorp/external/latest

provider "external" {
    #no version limit
}
/*
#adding for data reference
data "azurerm_client_config" "current" {} */