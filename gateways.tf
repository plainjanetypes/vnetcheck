#creating a public ip for the gateway
resource "azurerm_public_ip" "coregatewayip" {
        name = "CoreServicesVnetGateway-ip"
        sku = "Standard" #must if static
        allocation_method = "Static" #not dynamic for gateway ip
        location = azurerm_virtual_network.vnet1coreservices.location
        resource_group_name = azurerm_resource_group.rgvnet.name
}

#creating a virtual network gateway
resource "azurerm_virtual_network_gateway" "vnetgateway" {
        name = "CoreServicesVnetGateway"
        location = "eastus"
        resource_group_name = azurerm_resource_group.rgvnet.name

        type = "Vpn"
        vpn_type = "RouteBased"
        active_active = false
        sku = "VpnGw1"
        generation = "Generation1"
        enable_bgp = false
        
        ip_configuration {
                name = "VnetGateway-ip"
                private_ip_address_allocation = "Dynamic"
                public_ip_address_id = azurerm_public_ip.coregatewayip.id
                subnet_id = azurerm_subnet.subnet1gateway.id
        }


}