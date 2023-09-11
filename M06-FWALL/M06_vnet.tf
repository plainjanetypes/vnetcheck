
#creating RG for firewall - M06
resource "azurerm_resource_group" "fwrg" {
    name = "Test-FW-RG"
    location = "southeastasia"
    tags = {
            module = "M06"
            totest = "firewall-vhub-protection-mgr"
            }
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
