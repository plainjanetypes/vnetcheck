#creating a bastion host to connect to the vms for lb vnet
#creating a public ip
resource "azurerm_public_ip" "bastionhostpublicip" {
            name = "myBastionIP"
            allocation_method = "Dynamic"
            resource_group_name = azurerm_resource_group.lbrg.name
            location = azurerm_virtual_network.lbvnet.location  
}
#creating bastion host
resource "azurerm_bastion_host" "bastionhostlbvnet" {
            name = "myBastionHost"
            resource_group_name = azurerm_resource_group.lbrg.name
            location = azurerm_virtual_network.lbvnet.location
            sku = "Standard" #if changed to basic, force deletion - new host will be created 
            file_copy_enabled = true #can be done only for Standard sku
            ip_connect_enabled = true #can be done only for Standard sku
            scale_units = "2" #can be done only for Standard sku
            shareable_link_enabled = true #can be done only for Standard sku
            ip_configuration {
              name ="configip"
              subnet_id = azurerm_subnet.subnet3bastion.id
              public_ip_address_id = azurerm_public_ip.bastionhostpublicip.id
            }


}