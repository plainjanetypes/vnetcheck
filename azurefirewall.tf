#separate rg and vnet

#rg
resource "azurerm_resource_group" "fwrg" {
    name = "Test-FW-RG"
    location = "southeastasia"
}

#vnet
resource "azurerm_virtual_network" "fwvnet" {
            name = "Test-FW-VN"
            location = "southeastasia"
            resource_group_name = azurerm_resource_group.fwrg.name
            address_space = ["10.0.0.0/16"]
}
#adding 2 subnets for the fw vnet
#firewall subnet
resource "azurerm_subnet" "fwsubnet" {
            name = "AzureFirewallSubnet"
            resource_group_name = azurerm_resource_group.fwrg.name
            virtual_network_name = azurerm_virtual_network.fwvnet.name
            address_prefixes = ["10.0.1.0/26"]
}
#workload subnet
resource "azurerm_subnet" "workloadsubnet" {
            name = "Workload-SN"
            resource_group_name = azurerm_resource_group.fwrg.name
            virtual_network_name = azurerm_virtual_network.fwvnet.name
            address_prefixes = ["10.0.2.0/24"]
}

#a vm needs to be created under the workload subnet

#deploy azure firewall
#create a public ip
resource "azurerm_public_ip" "azfirewalllseapip" {
        name = "fw-pip"
        location = "southeastasia"
        resource_group_name = azurerm_resource_group.fwrg.name
        allocation_method = "Static"
        sku = "Standard"
}
#create the firewall
resource "azurerm_firewall" "azfirewalllsea" {
        name = "Test-FW01"
        location = "southeastasia"
        resource_group_name = azurerm_resource_group.fwrg.name
        sku_name = "AZFW_VNet"
        sku_tier = "Standard"

        ip_configuration {
          name = "configuration"
          subnet_id = azurerm_subnet.fwsubnet.id
          public_ip_address_id = azurerm_public_ip.azfirewalllseapip.id
        }
}
#create a route table, associate it with a subnet
resource "azurerm_route_table" "fwroutetable" {
        name = "Firewall-route"
        location = azurerm_resource_group.fwrg.location
        resource_group_name = azurerm_resource_group.fwrg.name
        disable_bgp_route_propagation = false
        route {
            name = "route-1"
            address_prefix = "0.0.0.0/0"
            next_hop_type = "VnetLocal"
        }
}
#route table and subnet association
resource "azurerm_subnet_route_table_association" "fwsubnetassociation" {
        subnet_id = azurerm_subnet.fwsubnet.id
        route_table_id = azurerm_route_table.fwroutetable.id
}