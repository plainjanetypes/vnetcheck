#creating a private dns zone

resource "azurerm_private_dns_zone" "cosorg" {
            name = "cosorg.com"
            resource_group_name = azurerm_resource_group.rgvnet.name  
}

#linking the pvt dns zone with corevnet //use case try with variables 
resource "azurerm_private_dns_zone_virtual_network_link" "CoreVnetLink" {
            name ="CoreServicesVnetLink"
            resource_group_name = azurerm_resource_group.rgvnet.name
            private_dns_zone_name = azurerm_private_dns_zone.cosorg.name
            virtual_network_id = azurerm_virtual_network.vnet1coreservices.id  
            registration_enabled = true
}

#linking the pvt dns zone with manufact vnet
resource "azurerm_private_dns_zone_virtual_network_link" "ManufactVnetLink" {
            name = "ManufacturingVnetLink"
            resource_group_name = azurerm_resource_group.rgvnet.name
            private_dns_zone_name = azurerm_private_dns_zone.cosorg.name
            virtual_network_id = azurerm_virtual_network.vnet2manufact.id
            registration_enabled = true
}

#linking the pvt dns zone with research vnet
resource "azurerm_private_dns_zone_virtual_network_link" "ResVnetLink" {
            name = "ResearchVnetLink"
            resource_group_name = azurerm_resource_group.rgvnet.name
            private_dns_zone_name = azurerm_private_dns_zone.cosorg.name
            virtual_network_id = azurerm_virtual_network.vnet3research.id
            registration_enabled = true  
}

#create 2 vms next, add/check A records for each in the dns zone (vms should auto register their ips in the dns zone if enabled) and 