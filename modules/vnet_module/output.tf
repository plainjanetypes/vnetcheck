#to get vnet id after creation
output "vnet_id" {
    value = azurerm_virtual_network.vnet-test.id  
}