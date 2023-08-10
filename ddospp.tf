#configure ddos protection on a vnet (new vs existing)
#only 1 ddos protection plan allowed per region + VERY costly

#ddos for an existing vnet - core - vnet1
resource "azurerm_network_ddos_protection_plan" "coreddosplan" {
    name = "MyDdoSProtectionPlan"
    location = azurerm_resource_group.rgvnet.location
    resource_group_name = azurerm_resource_group.rgvnet.name 
    #no vnet relationship drama - add a reference in the vnet block
}