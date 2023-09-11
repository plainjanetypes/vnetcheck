#creating publicip for app gateway
resource "azurerm_public_ip" "agpublicip" {
        name= "AGPublicIPAddress"
        sku = "Standard"
        allocation_method = "Dynamic"
        location = azurerm_resource_group.cosappgwrg.location
        resource_group_name = azurerm_resource_group.cosappgwrg.name
}


#creating application gateway
resource "azurerm_application_gateway" "cosag" {
        name = "CosAppGateway"
        location = "eastus"
        resource_group_name = azurerm_resource_group.cosappgwrg.name
        sku {
            name = "Standard_Small"
            tier = "Standard"
            capacity = 2
        }
        gateway_ip_configuration {
          name = "gateway-config"
          subnet_id = azurerm_subnet.agsubnet.id

        }
        frontend_port {
          name = local.frontend_port_name
          port = 80
        }
        frontend_ip_configuration {
          name = local.frontend_ip_configuration_name
          public_ip_address_id = azurerm_public_ip.agpublicip.id
        }
        backend_address_pool {
          name = local.backend_address_pool_name
        }
        backend_http_settings {
          name = local.http_setting_name
          cookie_based_affinity = "Disabled"
          path = "/"
          port = 80
          protocol = "Http"
          request_timeout = 60
        }
        http_listener {
          name = local.listener_name
          frontend_port_name = local.frontend_port_name
          protocol = "Http"
          frontend_ip_configuration_name = local.frontend_ip_configuration_name
        }
        request_routing_rule {
          name = local.request_routing_rule_name
          rule_type = "Basic"
          http_listener_name = local.listener_name
          backend_address_pool_name = local.backend_address_pool_name
          backend_http_settings_name = local.http_setting_name
        }
}