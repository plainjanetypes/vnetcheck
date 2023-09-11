#creating 2 nics via iteration - vm names in txt file
resource "azurerm_network_interface" "dnsvmsnics" {
    count = length(local.dnsvms)
    name = "nic-${replace(local.dnsvms[count.index], "\r","")})" #
    location = "eastus"
    resource_group_name = azurerm_resource_group.rgvnet.name
    ip_configuration {
        name = "pvtip-${local.dnsvms[count.index]}"
        subnet_id = azurerm_subnet.subnet3database.id
        private_ip_address_allocation = "Dynamic"
    }
}

#creating 2 vms via iteration - vm names in txt file
#both should be automatically added to the dns zone tagged to the subnet (check by loggin in and pinging the fqdn)

resource "azurerm_windows_virtual_machine" "dnsvms" {
    count = length(local.dnsvms)
    name = "${replace(local.dnsvms[count.index],"\r","")}"
    location = "eastus"
    resource_group_name = azurerm_resource_group.rgvnet.name
    network_interface_ids = [azurerm_network_interface.dnsvmsnics[count.index].id]
    admin_password = "Welcome@12345" #bad practice - needs to be in keyvault, added only for testing
    admin_username = "vmadmin"
    size = "Standard_D2s_v3"

    source_image_reference {
        publisher = "Microsoft"
        offer = "WindowsServer"
        sku = "2016-datacenter"
        version = "latest"   
    }
    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

}