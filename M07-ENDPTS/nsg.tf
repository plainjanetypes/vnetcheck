#create a network security group
resource "azurerm_network_security_group" "cusnsg" {
  name = "cuspvtnsg"
  resource_group_name = azurerm_resource_group.resgrp.name
  location = "eastus"
}