#M03 - Unit 4 Configure an ExpressRoute Gateway
#M03 - Unit 5 Provision an ExpressRoute circuit

#create public ip
resource "azurerm_public_ip" "ergatewaypublicip" {
    name = "CoreServicesERGateway-IP"
    location = azurerm_virtual_network.vnet1coreservices.location
    resource_group_name = azurerm_resource_group.rgvnet.name
    allocation_method = "Dynamic"
    tags = {
        module = "M03"
        totest = "ER"
    }
}
#vnet gateway for expressroute - uses corevnet, not using azurerm_express_route_gateway
resource "azurerm_virtual_network_gateway" "ergateway" {
        name = "CoreServicesERGateway"
        location = azurerm_virtual_network.vnet1coreservices.location
        resource_group_name = azurerm_resource_group.rgvnet.name
        type = "ExpressRoute"
        sku = "Standard"
        ip_configuration {
            name = "ergatewayconfig"
            public_ip_address_id = azurerm_public_ip.ergatewaypublicip.id
            private_ip_address_allocation = "Dynamic"
            subnet_id = azurerm_subnet.subnet1gateway.id 
        }
        tags = {
        module = "M03"
        totest = "ER"
        }
}
#create an expressroute circuit - once provisioned share the service key with provider else will not work
resource "azurerm_express_route_circuit" "ercircuit" {
        name = "TestERCircuit"
        location = azurerm_resource_group.rgvnet.location
        resource_group_name = azurerm_resource_group.rgvnet.name
        service_provider_name = "Equinix"
        peering_location = "Seattle"
        bandwidth_in_mbps = "50"
        sku {
          tier = "Standard"
          family = "MeteredData"
        }
        tags = {
        module = "M03"
        totest = "ER"
        }
}
/* #create an expressroute circuit connection IF peering
resource "azurerm_express_route_circuit_connection" "ercircuitconnxn" {
    name = "er-connection"
    location = azurerm_resource_group.rgvnet.location
    resource_group_name = azurerm_resource_group.rgvnet.name

} */