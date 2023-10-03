#create rg
resource "azurerm_resource_group" "resgrp" {
    name = "cusrg"
    location = "eastus"
  
}
#creating a vnet
resource "azurerm_virtual_network" "cusvnet" {
    name = "cusvnet"
    location = "eastus"
    address_space = ["10.0.0.0/16"]
    resource_group_name = azurerm_resource_group.resgrp.name
}

#create a subnet - public
resource "azurerm_subnet" "publiccussubnet" {
    name = "Public"
    address_prefixes = ["10.0.0.0/24"]
    virtual_network_name = azurerm_virtual_network.cusvnet.name
}
#create a subnet - private (with service endpoint - storage)
resource "azurerm_subnet" "pvtcussubnet" {
    name = "Private"
    address_prefixes = ["10.0.1.0/24"]
    virtual_network_name = azurerm_virtual_network.cusvnet.name
    service_endpoints = ["Microsoft.Storage"]
}