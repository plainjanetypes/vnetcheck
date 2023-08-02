#creating a WAN 
resource "azurerm_virtual_wan" "VWan" {
        name = "CosOrgVirtualWAN"
        resource_group_name = azurerm_resource_group.rgvnet.name
        location = "eastus" #WAN is a global resource though, doesnt need a specific region
        type = "Standard"
}

#creating a virtual hub
resource "azurerm_virtual_hub" "VHub" {
        name ="ContosoVirtualWANHub-WestUS"
        location = "westus"
        resource_group_name = azurerm_resource_group.rgvnet.name
        virtual_wan_id = azurerm_virtual_wan.VWan.id
        address_prefix = "10.0.0.0/23"
}

#attach this vhub to researchvnet to allow vhub (westus) to talk to vnet (seasia)
resource "azurerm_virtual_hub_connection" "CosWAN_research" {
        name = "ContosoVirtualWAN-to-ResearchVNet"
        virtual_hub_id = azurerm_virtual_hub.VHub.id
        remote_virtual_network_id = azurerm_virtual_network.vnet3research.id
}