locals {
      #local variable for reading vm names and assigned to variable defined in variables tf -commented as powershell is not giving desired o/p
      #appgwvms_output = (data.external.appgwvmslist.result)  #not added in variables.tf (1 variable defined, unused)
      #appgwvms_output = [ split("\n", file("${path.module}/readappgwvms.txt"))]
      #appgwvms_output = toset(split("\n", chomp(file("${path.module}/readappgwvms.txt")))) #chomp to remove trail space
      appgwvms_output = [for vm in split("\n", chomp(file("${path.module}/readappgwvms.txt"))) : trimspace(vm)]
      #appgwvms_network_interface_ids = [ for i in range(length(local.appgwvms_output)) : azurerm_network_interface.appgwvmnics34[i].id]
      #appgwvms_network_interface_ids = [ for nic in azurerm_azurerm_network_interface.appgwvmnics34 : nic.id ]
      #local variable for app gateway
      backend_address_pool_name = "${azurerm_virtual_network.cosappgwvnet.name}-backendpool"
      frontend_port_name = "${azurerm_virtual_network.cosappgwvnet.name}-feport"
      frontend_ip_configuration_name = "${azurerm_virtual_network.cosappgwvnet.name}-feip"
      http_setting_name = "${azurerm_virtual_network.cosappgwvnet.name}-httpsetting"
      listener_name = "${azurerm_virtual_network.cosappgwvnet.name}-listener"
      request_routing_rule_name = "${azurerm_virtual_network.cosappgwvnet.name}-reqrout"
      redirect_configuration_name = "${azurerm_virtual_network.cosappgwvnet.name}-redirectconfig"
      }
