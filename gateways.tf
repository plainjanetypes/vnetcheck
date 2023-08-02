#creating a public ip for the core service gateway 
resource "azurerm_public_ip" "coregatewayip" {
        name = "CoreServicesVnetGateway-ip"
        sku = "Standard" #must if static
        allocation_method = "Static" #not dynamic for gateway ip
        location = azurerm_virtual_network.vnet1coreservices.location
        resource_group_name = azurerm_resource_group.rgvnet.name
}
#creating a public ip for manufacturing gateway
resource "azurerm_public_ip" "manufactgatewayip" {
        name = "ManufacturingVnetGateway-ip"
        sku = "Standard"
        allocation_method = "Static"
        location = azurerm_virtual_network.vnet2manufact.location
        resource_group_name = azurerm_resource_group.rgvnet.name
}

#creating a virtual network gateway for coreservices vnet
resource "azurerm_virtual_network_gateway" "vnetcoregateway" {
        name = "CoreServicesVnetGateway"
        location = azurerm_virtual_network.vnet1coreservices.location
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
#creating a virtual network gateway for manufacturing vnet
resource "azurerm_virtual_network_gateway" "vnetmanufactgateway" {
        name = "ManufacturingVnetGateway"
        location = azurerm_virtual_network.vnet2manufact.location
        resource_group_name = azurerm_resource_group.rgvnet.name

        type = "Vpn"
        vpn_type = "RouteBased"
        active_active = false
        enable_bgp = false
        sku = "VpnGw1"
        generation = "Generation1"

        ip_configuration {
                name = "VnetGateway-ip"
                private_ip_address_allocation = "Dynamic"
                public_ip_address_id = azurerm_public_ip.manufactgatewayip.id
                subnet_id = azurerm_subnet.subnet5gateway.id
        }
}