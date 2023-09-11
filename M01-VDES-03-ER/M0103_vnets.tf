#M01-Unit 4 Design and implement a Virtual Network in Azure

#contains M01 Vnets - used across M01-M03

#creating RG for main vnets- M01 
resource "azurerm_resource_group" "rgvnet" {
    name = "cosorg"
    location = "eastus"
    tags = {
            module = "M01,M02,M03,M06"
            totest = "vnet-design,global-vnet-peering,bidir-vnet-gateways (vnet-to-vnet),vnet-gateway,ER,DDos-protection"
          }
}

#vnets and subnets - M01
#vnet1
resource "azurerm_virtual_network" "vnet1coreservices" {
            name = "CoreServicesVnet"
            location = "eastus"
            address_space = ["10.20.0.0/16"]
            resource_group_name = azurerm_resource_group.rgvnet.name
            #adding DDoS plan addition - originally from M06, moved to M01 as enabled on vnet
            ddos_protection_plan {
              id = azurerm_network_ddos_protection_plan.coreddosplan.id
              enable = true
            }
            tags = {
                module = "M01,M02,M06"
                totest = "vnet-design,global-vnet-peering,bidir-vnet-gateways (vnet-to-vnet),DDos-protection"
                ddos_enabled = "true"
                }
}

#subnets for vnet1 - //all 4 created without iteration/for each etc.
resource "azurerm_subnet" "subnet1gateway" {
            name = "GatewaySubnet"
            resource_group_name = azurerm_resource_group.rgvnet.name
            virtual_network_name = azurerm_virtual_network.vnet1coreservices.name
            address_prefixes = ["10.20.0.0/27"]
}
resource "azurerm_subnet" "subnet2sharedservices" {
            name = "SharedServicesSubnet"
            resource_group_name = azurerm_resource_group.rgvnet.name
            virtual_network_name = azurerm_virtual_network.vnet1coreservices.name
            address_prefixes = ["10.20.10.0/24"]
}
resource "azurerm_subnet" "subnet3database" {
            name = "DatabaseSubnet"
            resource_group_name = azurerm_resource_group.rgvnet.name
            virtual_network_name = azurerm_virtual_network.vnet1coreservices.name
            address_prefixes = ["10.20.20.0/24"] #based on screenshot for verification, 10.20.x.x ips therefore, same subnet used in dns vms
}
resource "azurerm_subnet" "subnet4publicweb" {
            name = "PublicWebServiceSubnet"
            resource_group_name = azurerm_resource_group.rgvnet.name
            virtual_network_name = azurerm_virtual_network.vnet1coreservices.name
            address_prefixes = ["10.20.30.0/24"]
}

#vnet2
resource "azurerm_virtual_network" "vnet2manufact" {
            name = "ManufacturingVnet"
            location = "westeurope"
            resource_group_name = azurerm_resource_group.rgvnet.name
            address_space = ["10.30.0.0/16"]
            tags = {
                module = "M01,M02"
                totest = "vnet-design,global-vnet-peering,bidir-vnet-gateways (vnet-to-vnet)"
                }
}

#subnets for vnet2
resource "azurerm_subnet" "subnet1manufactsys" {
            name = "ManufacturingSystemSubnet"
            resource_group_name = azurerm_resource_group.rgvnet.name
            virtual_network_name = azurerm_virtual_network.vnet2manufact.name
            address_prefixes = ["10.30.10.0/24"]
}
#newsubnet for gateway for vnet2
resource "azurerm_subnet" "subnet5gateway" {
            name = "GatewaySubnet"
            resource_group_name = azurerm_resource_group.rgvnet.name
            virtual_network_name = azurerm_virtual_network.vnet2manufact.name
            address_prefixes = ["10.30.0.0/27"]
}

#subnet 2 to 4 - trying for each loop
resource "azurerm_subnet" "subnet2to4" {
            for_each = var.subnets

            name = each.value.name
            address_prefixes = [each.value.address_prefix]
            resource_group_name = azurerm_resource_group.rgvnet.name
            virtual_network_name = azurerm_virtual_network.vnet2manufact.name
}

#vnet3
resource "azurerm_virtual_network" "vnet3research" {
            name = "ResearchVnet"
            location = "southeastasia"
            resource_group_name = azurerm_resource_group.rgvnet.name
            address_space = ["10.40.0.0/16"]
            tags = {
                module = "M01,M02"
                totest = "vnet-design,vwan"
                }
}
#subnet for vnet 3
resource "azurerm_subnet" "subnet1research" {
            name = "ResearchSystemSubnet"
            address_prefixes = ["10.40.0.0/24"]
            resource_group_name = azurerm_resource_group.rgvnet.name
            virtual_network_name = azurerm_virtual_network.vnet3research.name
          
}