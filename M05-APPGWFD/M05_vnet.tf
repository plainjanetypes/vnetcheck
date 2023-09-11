

#creating RG for app gw vnet - M05
resource "azurerm_resource_group" "cosappgwrg" {
    name = "cosappgwrg"
    location = "eastus"
    tags = {
            module = "M05"
            totest = "appgateway-frontdoor"
            }
}

#vnet for app gateway - vnet5
resource "azurerm_virtual_network" "cosappgwvnet" {
            name = "cosappgwVnet"
            location = "eastus"
            resource_group_name = azurerm_resource_group.cosappgwrg.name
            address_space = ["10.0.0.0/16"]
}
#subnet for appgw - default
resource "azurerm_subnet" "agsubnet" {
            name = "AGSubnet"
            resource_group_name = azurerm_resource_group.cosappgwrg.name
            virtual_network_name = azurerm_virtual_network.cosappgwvnet.name
            address_prefixes = ["10.0.0.0/24"]
}
#subnet for appgw - backend
resource "azurerm_subnet" "appgwbackendsubnet" {
            name = "BackendSubnet"
            resource_group_name = azurerm_resource_group.cosappgwrg.name
            virtual_network_name = azurerm_virtual_network.cosappgwvnet.name
            address_prefixes = ["10.0.1.0/24"]
}