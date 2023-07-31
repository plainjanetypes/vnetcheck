# create an nsg and add rules

resource "azurerm_network_security_group" "genericnsg" {
            name = "nsgall"
            location = "centralus"
            resource_group_name = azurerm_resource_group.rgvnet.name

            security_rule {
                name                        = "allowall"
                priority                    = 100
                direction                   = "Inbound"
                access                      = "Allow"
                protocol                    = "Tcp"
                source_port_range           = "*"
                destination_port_range      = "*"
                source_address_prefix       = "*"
                destination_address_prefix  = "*"
                #resource_group_name         = azurerm_resource_group.rgvnet.name
                #network_security_group      = azurerm_network_security_group.genericnsg.id
            }
            /*
            security_rule {
                name                        = "allowicmp"
                priority                    = 110
                direction                   = "Inbound"
                access                      = "Allow"
                protocol                    = "icmp"
                source_port_range           = "*"
                destination_port_range      = "*"
                source_address_prefix       = "*"
                destination_address_prefix  = "*"
                resource_group_name         = azurerm_network_security_group.genericnsg.name
                network_security_group_name = azurerm_network_security_group.genericnsg.name
            }

            security_rule {
                name                        = "allowhttps"
                priority                    = 120
                direction                   = "Inbound"
                access                      = "Allow"
                protocol                    = "Tcp"
                source_port_range           = "443"
                destination_port_range      = "*"
                source_address_prefix       = "*"
                destination_address_prefix  = "*"
                resource_group_name         = azurerm_network_security_group.genericnsg.name
                network_security_group_name = azurerm_network_security_group.genericnsg.name
            }*/
            /*
            security_rule {
                name                        = "allowall"
                priority                    = 100
                direction                   = "Inbound"
                access                      = "Allow"
                protocol                    = "Tcp"
                source_port_range           = "*"
                destination_port_range      = "*"
                source_address_prefix       = "*"
                destination_address_prefix  = "*"
                resource_group_name         = azurerm_network_security_group.genericnsg.name
                network_security_group_name = azurerm_network_security_group.genericnsg.name
            }

            security_rule {
                name                        = "allowall"
                priority                    = 100
                direction                   = "Inbound"
                access                      = "Allow"
                protocol                    = "Tcp"
                source_port_range           = "*"
                destination_port_range      = "*"
                source_address_prefix       = "*"
                destination_address_prefix  = "*"
                resource_group_name         = azurerm_network_security_group.genericnsg.name
                network_security_group_name = azurerm_network_security_group.genericnsg.name
            }

            security_rule {
                name                        = "allowall"
                priority                    = 100
                direction                   = "Inbound"
                access                      = "Allow"
                protocol                    = "Tcp"
                source_port_range           = "*"
                destination_port_range      = "*"
                source_address_prefix       = "*"
                destination_address_prefix  = "*"
                resource_group_name         = azurerm_network_security_group.genericnsg.name
                network_security_group_name = azurerm_network_security_group.genericnsg.name
            }  

            security_rule {
                name                        = "allowall"
                priority                    = 100
                direction                   = "Inbound"
                access                      = "Allow"
                protocol                    = "Tcp"
                source_port_range           = "*"
                destination_port_range      = "*"
                source_address_prefix       = "*"
                destination_address_prefix  = "*"
                resource_group_name         = azurerm_network_security_group.genericnsg.name
                network_security_group_name = azurerm_network_security_group.genericnsg.name
            }

            security_rule {
                name                        = "allowall"
                priority                    = 100
                direction                   = "Inbound"
                access                      = "Allow"
                protocol                    = "Tcp"
                source_port_range           = "*"
                destination_port_range      = "*"
                source_address_prefix       = "*"
                destination_address_prefix  = "*"
                resource_group_name         = azurerm_network_security_group.genericnsg.name
                network_security_group_name = azurerm_network_security_group.genericnsg.name
            }

            security_rule {
                name                        = "allowall"
                priority                    = 100
                direction                   = "Inbound"
                access                      = "Allow"
                protocol                    = "Tcp"
                source_port_range           = "*"
                destination_port_range      = "*"
                source_address_prefix       = "*"
                destination_address_prefix  = "*"
                resource_group_name         = azurerm_network_security_group.genericnsg.name
                network_security_group_name = azurerm_network_security_group.genericnsg.name
            }

            security_rule {
                name                        = "allowall"
                priority                    = 100
                direction                   = "Inbound"
                access                      = "Allow"
                protocol                    = "Tcp"
                source_port_range           = "*"
                destination_port_range      = "*"
                source_address_prefix       = "*"
                destination_address_prefix  = "*"
                resource_group_name         = azurerm_network_security_group.genericnsg.name
                network_security_group_name = azurerm_network_security_group.genericnsg.name
            }

            security_rule {
                name                        = "allowall"
                priority                    = 100
                direction                   = "Inbound"
                access                      = "Allow"
                protocol                    = "Tcp"
                source_port_range           = "*"
                destination_port_range      = "*"
                source_address_prefix       = "*"
                destination_address_prefix  = "*"
                resource_group_name         = azurerm_network_security_group.genericnsg.name
                network_security_group_name = azurerm_network_security_group.genericnsg.name
            }

            security_rule {
                name                        = "allowall"
                priority                    = 100
                direction                   = "Inbound"
                access                      = "Allow"
                protocol                    = "Tcp"
                source_port_range           = "*"
                destination_port_range      = "*"
                source_address_prefix       = "*"
                destination_address_prefix  = "*"
                resource_group_name         = azurerm_network_security_group.genericnsg.name
                network_security_group_name = azurerm_network_security_group.genericnsg.name
            }

            security_rule {
                name                        = "allowall"
                priority                    = 100
                direction                   = "Inbound"
                access                      = "Allow"
                protocol                    = "Tcp"
                source_port_range           = "*"
                destination_port_range      = "*"
                source_address_prefix       = "*"
                destination_address_prefix  = "*"
                resource_group_name         = azurerm_network_security_group.genericnsg.name
                network_security_group_name = azurerm_network_security_group.genericnsg.name
            }

            security_rule {
                name                        = "allowall"
                priority                    = 100
                direction                   = "Inbound"
                access                      = "Allow"
                protocol                    = "Tcp"
                source_port_range           = "*"
                destination_port_range      = "*"
                source_address_prefix       = "*"
                destination_address_prefix  = "*"
                resource_group_name         = azurerm_network_security_group.genericnsg.name
                network_security_group_name = azurerm_network_security_group.genericnsg.name
            }

            security_rule {
                name                        = "allowall"
                priority                    = 100
                direction                   = "Inbound"
                access                      = "Allow"
                protocol                    = "Tcp"
                source_port_range           = "*"
                destination_port_range      = "*"
                source_address_prefix       = "*"
                destination_address_prefix  = "*"
                resource_group_name         = azurerm_network_security_group.genericnsg.name
                network_security_group_name = azurerm_network_security_group.genericnsg.name
            }
            */
            
}