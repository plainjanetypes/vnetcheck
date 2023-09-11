
#deploy azure firewall
#create a public ip
resource "azurerm_public_ip" "azfirewalllseapip" {
        name = "fw-pip"
        location = "southeastasia"
        resource_group_name = azurerm_resource_group.fwrg.name
        allocation_method = "Static"
        sku = "Standard"
}
#create the firewall
resource "azurerm_firewall" "azfirewalllsea" {
        name = "Test-FW01"
        location = "southeastasia"
        resource_group_name = azurerm_resource_group.fwrg.name
        sku_name = "AZFW_VNet"
        sku_tier = "Standard"

        ip_configuration {
          name = "configuration"
          subnet_id = azurerm_subnet.fwsubnet.id
          public_ip_address_id = azurerm_public_ip.azfirewalllseapip.id
        }
}
#create a route table, associate it with a subnet
resource "azurerm_route_table" "fwroutetable" {
        name = "Firewall-route"
        location = azurerm_resource_group.fwrg.location
        resource_group_name = azurerm_resource_group.fwrg.name
        disable_bgp_route_propagation = false
        route {
            name = "route-1"
            address_prefix = "0.0.0.0/0"
            next_hop_type = "VnetLocal"
        }
}
#route table and subnet association
resource "azurerm_subnet_route_table_association" "fwsubnetassociation" {
        subnet_id = azurerm_subnet.fwsubnet.id
        route_table_id = azurerm_route_table.fwroutetable.id
}
#add firewall rule
#nw rule
resource "azurerm_firewall_network_rule_collection" "nwrules" {
        name = "Net-Coll01"
        priority = "100"
        #rule_collection_type = "Network"
        action = "Allow"
        #rule_group_name = "DefaultNetworkRuleCollectionGroup"
        resource_group_name = azurerm_resource_group.fwrg.name
        azure_firewall_name = azurerm_firewall.azfirewalllsea.name

        rule {
            name = "Allow-DNS"
            #rule_type = "IPMatch"
            source_addresses = ["10.0.2.0/24"]
            protocols = ["UDP"]
            destination_ports = ["53"]
            destination_addresses = ["209.244.0.3", "209.244.0.4"]
        }
}
#app rule
resource "azurerm_firewall_application_rule_collection" "apprules" {
        name = "App-Coll01"
        priority = "200"
        #rule_collection_type = "Application"
        action = "Allow"
        #rule_group_name = "	DefaultApplicationRuleCollectionGroup"
        azure_firewall_name = azurerm_firewall.azfirewalllsea.name
        resource_group_name = azurerm_resource_group.fwrg.name

        rule {
            name = "Allow-Google"
            #rule_type = "IP Address"
            source_addresses = ["10.0.2.0/24"]
            #protocols = ["http","https"]
            #destination_type = "FQDN"
            #destination_addresses = "www.google.com"
            #destination_ports =["53"]
            #destination_addresses = [""]
        }
}
#nat rule
resource "azurerm_firewall_nat_rule_collection" "natrules" {
        name = "rdp"
        priority = 200
        resource_group_name = azurerm_resource_group.fwrg.name
        action = "Dnat"
        azure_firewall_name = azurerm_firewall.azfirewalllsea.name

        
        rule {
            name = "rdp-nat"
            destination_ports = ["3389"]
            destination_addresses =  ["20.90.136.51"] #azurerm_public_ip.azfirewalllseapip.ip_address  #needs to be deployed after creation
            protocols = ["Any"]
            translated_port = "3389"
            translated_address = "10.03.4.5"
        }
        
}

#for the virtual machines, 2nics to be created and dns servers to be added for them
