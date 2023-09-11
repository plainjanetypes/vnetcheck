#creating RG for lb vnet - M04
resource "azurerm_resource_group" "lbrg" {
    name = "coslb-RG"
    location = "eastus"  
    tags = {
            module = "M04"
            totest = "load-bal-traffic-mgr"
            }
}

#vnet for load balancer - vnet4
resource "azurerm_virtual_network" "lbvnet" {
            name = "CosLB-VNet"
            location = "eastus"
            resource_group_name = azurerm_resource_group.lbrg.name
            address_space = ["10.1.0.0/16"]
}
#adding 2 subnets for the lb vnet
#backend
resource "azurerm_subnet" "subnet1backend" {
            name = "myBackendSubnet"
            resource_group_name = azurerm_resource_group.lbrg.name
            virtual_network_name = azurerm_virtual_network.lbvnet.name
            address_prefixes = ["10.1.0.0/24"]
}
#frontend
resource "azurerm_subnet" "subnet2frontend" {
            name = "myFrontEndSubnet"
            resource_group_name = azurerm_resource_group.lbrg.name
            virtual_network_name = azurerm_virtual_network.lbvnet.name
            address_prefixes = ["10.1.2.0/24"]
}
#bastionsubnet for connecting to the vms
resource "azurerm_subnet" "subnet3bastion" {
            name = "AzureBastionSubnet"
            resource_group_name = azurerm_resource_group.lbrg.name
            virtual_network_name = azurerm_virtual_network.lbvnet.name
            address_prefixes = ["10.1.1.0/24"] #should be min /26 and have the exact name
}

