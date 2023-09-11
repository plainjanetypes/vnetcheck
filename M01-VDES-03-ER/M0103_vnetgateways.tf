#M02 - Unit 3 Create and configure a virtual network gateway

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

#creating a bidirectional connection between the two gateways created as both are from different regions (us and europe)

#core to manufact connection - between vnet gateways - us to europe
resource "azurerm_virtual_network_gateway_connection" "coretomanu_eastustoeurope" {
        name = "CoreServicesGW-to-ManufacturingGW"
        resource_group_name = azurerm_resource_group.rgvnet.name
        location = azurerm_virtual_network.vnet1coreservices.location # points to eastus

        type = "Vnet2Vnet"
        virtual_network_gateway_id = azurerm_virtual_network_gateway.vnetcoregateway.id
        peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.vnetmanufactgateway.id

        shared_key = "abc123" #bad - keyvault needed
}

#manufact to core connection - between vnet gateways - europe to us
resource "azurerm_virtual_network_gateway_connection" "manutocore_europetoeastus" {
        name = "ManufacturingGW-to-CoreServicesGW"
        resource_group_name = azurerm_resource_group.rgvnet.name
        location = azurerm_virtual_network.vnet2manufact.location #points to europe

        type = "Vnet2Vnet"
        virtual_network_gateway_id = azurerm_virtual_network_gateway.vnetmanufactgateway.id
        peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.vnetcoregateway.id

        shared_key = "abc123"  #bad - keyvault needed
}
