resource "azurerm_virtual_network" "vnet-test" {
    name = var.vnet_name
    location = var.location
    address_space = var.address_space
    resource_group_name = data.azurerm_resource_group.rg-test.name #hardcoded but separate module later
}
resource "azurerm_subnet" "subnet-test" {
    count = length(var.subnets)
    name = var.subnets[count.index].name
    address_prefixes = var.subnets[count.index].address_prefix
    resource_group_name = data.azurerm_resource_group.rg-test.name
    virtual_network_name = azurerm_virtual_network.vnet-test.name  
}
