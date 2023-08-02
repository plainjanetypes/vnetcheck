# create a vnet - 4 subnets, 4 nic, 2 nsg for 2 subnets

#creating a resource group >> resource block
resource "azurerm_resource_group" "rgvnet" {
            name = "cosorg"
            location = "eastus"
}
#creating RG for lb vnet
resource "azurerm_resource_group" "lbrg" {
            name = "IntLB-RG"
            location = "eastus"  
}

#vnet1
resource "azurerm_virtual_network" "vnet1coreservices" {
            name = "CoreServicesVnet"
            location = "eastus"
            address_space = ["10.20.0.0/16"]
            resource_group_name = azurerm_resource_group.rgvnet.name
}

#subnets for vnet1 - //use case - using foreach for 4 subnets
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
            address_prefixes = ["10.20.20.0/24"]
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
}
#subnet for vnet 3
resource "azurerm_subnet" "subnet1research" {
            name = "ResearchSystemSubnet"
            address_prefixes = ["10.40.0.0/24"]
            resource_group_name = azurerm_resource_group.rgvnet.name
            virtual_network_name = azurerm_virtual_network.vnet3research.name
}

/*
resource "azurerm_network_interface" "nicapp" {
            name = "nic1"
            location = "centralus"
            resource_group_name = azurerm_resource_group.rgvnet.name
            ip_configuration {
                name = "internalapp-ip"
                subnet_id = azurerm_subnet.subnet1.id #usecase for multiple subnets
                private_ip_address_allocation = "Dynamic"
            }
}*/

#vnet for load balancer
resource "azurerm_virtual_network" "lbvnet" {
            name = "IntLB-VNet"
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

