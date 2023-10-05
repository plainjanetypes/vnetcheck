#create a network security group
resource "azurerm_network_security_group" "cusnsg" {
  name = "cuspvtnsg"
  resource_group_name = azurerm_resource_group.resgrp.name
  location = "eastus"
}

#create nsg rules
resource "azurerm_network_security_rule" "cusruleson1" {
  name                        = "Allow-Storage_All"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VNet.EastUS"
  destination_address_prefix  = "Storage.EastUS"
  resource_group_name         = azurerm_resource_group.resgrp.name
  network_security_group_name = azurerm_network_security_group.cusnsg.name
}

resource "azurerm_network_security_rule" "cusruleson2" {
  name                        = "Deny-Internal_All"
  priority                    = 101
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VNet.EastUS"
  destination_address_prefix  = "Internet"
  resource_group_name         = azurerm_resource_group.resgrp.name
  network_security_group_name = azurerm_network_security_group.cusnsg.name
}
resource "azurerm_network_security_rule" "cusrulesin1" {
  name                        = "Allow-RDP_All"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.resgrp.name
  network_security_group_name = azurerm_network_security_group.cusnsg.name
}