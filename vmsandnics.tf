#coreservices vnet - vm1


#manufacturing vnet - vm1
/*
#creating 2 vms for load balancer testing
#need to define variables first
resource "azurerm_virtual_machine" "lbvm1" {
        
  
}*/

#nic creation for vms via loop
resource "azurerm_network_interface" "nic12forlbvms" {
            count = length(var.virtual_machineslb)
            name = "nic-${var.virtual_machineslb[count.index]}"
            location = azurerm_resource_group.lbrg.location
            resource_group_name = azurerm_resource_group.lbrg.name
            ip_configuration {
                name = "pvtip-${var.virtual_machineslb[count.index]}"
                subnet_id = azurerm_subnet.subnet1backend.id #for adding to backend pool
                private_ip_address_allocation = "Dynamic"
            }
}
