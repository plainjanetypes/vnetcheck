# create a vnet - 4 subnets, 4 nic, 2 nsg for 2 subnets

#creating a resource group >> resource block
resource "azurerm_resource_group" "rgvnet" {
            name = "rgvnet1"
            location = "centralus"
}

resource "azurerm_virtual_network" "vnet1" {
            name = "vnet1"
            location = "centralus"
            address_space = ["10.0.0.0/16"]
            resource_group_name = azurerm_resource_group.rgvnet.name
}

#subnet 1 - use case - using foreach for 4 subnets
resource "azurerm_subnet" "subnet1" {
            name = "subnetapp"
            resource_group_name = azurerm_resource_group.rgvnet.name
            virtual_network_name = azurerm_virtual_network.vnet1.name
            address_prefixes = ["10.0.0.0/28"]
}

resource "azurerm_network_interface" "nicapp" {
            name = "nic1"
            location = "centralus"
            resource_group_name = azurerm_resource_group.rgvnet.name
            ip_configuration {
                name = "internalapp-ip"
                subnet_id = azurerm_subnet.subnet1.id #usecase for multiple subnets
                private_ip_address_allocation = "Dynamic"
            }
}
