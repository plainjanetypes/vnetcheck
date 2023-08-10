
#create nics via loop - local variable used
resource "azurerm_network_interface" "appgwvmnics34" {
    #count = length(local.appgwvms_output) #not to use 
    #name = "nic-${local.appgwvms_output[count.index]}"

    for_each = local.appgwvms_output
    name = "nic-${each.key}"
    location = azurerm_resource_group.cosappgwrg.location
    resource_group_name = azurerm_resource_group.cosappgwrg.name
    ip_configuration {
      #name = "pvtip-${local.appgwvms_output[count.index]}"
      name = "pvtip-${each.key}"
      subnet_id = azurerm_subnet.appgwbackendsubnet.id
      private_ip_address_allocation = "Dynamic"
    }
}

/*
#create vms via loop - local variable used
resource "azurerm_windows_virtual_machine" "appgwvms34" {
    #count = length(local.appgwvms_output)
    for_each = toset(local.appgwvms_output)
    #name = "${local.appgwvms_output[count.index]}"
    name = "${each.key}"
    location = azurerm_resource_group.cosappgwrg.location
    resource_group_name = azurerm_resource_group.cosappgwrg.name
    #network_interface_ids = [azurerm_network_interface.appgwvmnics34[count.index].id]
    network_interface_ids = [azurerm_network_interface.appgwvmnics34] #created a local variable for loop- pulling the ids
    admin_username = "vmadmin"
    admin_password = sensitive(var.admin_password)
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
*/
