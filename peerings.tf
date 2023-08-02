#creating  a bidirectional vnet peering between core and manufact vnets
#peering link 1 from core to manufact
resource "azurerm_virtual_network_peering" "peering1" {
        name = "CoreServicesVnet-to-ManufacturingVnet"
        resource_group_name = azurerm_resource_group.rgvnet.name
        virtual_network_name = azurerm_virtual_network.vnet1coreservices.name
        remote_virtual_network_id = azurerm_virtual_network.vnet2manufact.id
        #allow vms in the remote vnet to access vms in local vnet, default = true
        allow_virtual_network_access = true
        #allow forwarded traffic from vms in remote vnet, default = false
        allow_forwarded_traffic = true
        #not testing with gateways, use_remote_gateways = default false, not added
        }

#peering link 2 from manufact to core
resource "azurerm_virtual_network_peering" "peering2" {
        name = "ManufacturingVnet-to-CoreServicesVnet"
        resource_group_name = azurerm_resource_group.rgvnet.name
        virtual_network_name = azurerm_virtual_network.vnet2manufact.name
        remote_virtual_network_id = azurerm_virtual_network.vnet1coreservices.id
        allow_forwarded_traffic = true
        allow_virtual_network_access = true
        }

