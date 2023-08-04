#coreservices vnet - vm1


#manufacturing vnet - vm1
/*
#creating 3 vms for load balancer testing
#need to define variables first */

#nic creation for 3 vms via loop
resource "azurerm_network_interface" "nic1-3forlbvms" {
            count = length(var.virtual_machineslb)
            name = "nic-${var.virtual_machineslb[count.index]}" #for name nic-myvm1
            location = azurerm_resource_group.lbrg.location
            resource_group_name = azurerm_resource_group.lbrg.name
            ip_configuration {
                name = "pvtip-${var.virtual_machineslb[count.index]}"
                subnet_id = azurerm_subnet.subnet1backend.id #for adding to backend pool
                private_ip_address_allocation = "Dynamic"
            }
}
#specify which backend pool the nics should belong to
resource "azurerm_network_interface_backend_address_pool_association" "backendpoolandnics" {
            count = length(var.virtual_machineslb)
            network_interface_id = element(azurerm_network_interface.nic1-3forlbvms.*.id, count.index)
            backend_address_pool_id = azurerm_lb_backend_address_pool.backendpool.id
            ip_configuration_name = "pvtip-${var.virtual_machineslb[count.index]}"
}

#vm creation
#azurerm_virtual_machine resource has been superseded by the azurerm_linux_virtual_machine and azurerm_windows_virtual_machine 
resource "azurerm_windows_virtual_machine" "vms12"{
    count = length(var.virtual_machineslb)
    name = "${var.virtual_machineslb[count.index]}" #for name myvm1
    location = azurerm_resource_group.lbrg.location
    resource_group_name = azurerm_resource_group.lbrg.name
    network_interface_ids = [azurerm_network_interface.nic1-3forlbvms[count.index].id] #nicreference as per count
    admin_username = "vmadmin"
    #hide the password using sensitive variable
    admin_password = sensitive(var.admin_password) #this can be added in .tfvars or when applying the changes as -var= or via keyvault
    size = "Standard_D2S_v3"

    source_image_reference {
            publisher = "MicrosoftWindowsServer"
            offer = "WindowsServer"
            sku = "2016-datacenter"
            version = "latest"      
            }
    os_disk {
            caching = "ReadWrite"
            storage_account_type = "Standard_LRS"
    }



}