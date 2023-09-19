
#adding a data block for reading the env variables (ps is external source)
data "external" "azuredetails" {
    #program = ["powershell", "-Command", "$Env:TF_TENANT; $Env:TF_OBJECT"] #here powershell exe runs a command /script specified
    program = ["powershell", ".\\azuredetails.ps1"]
} 
data "azurerm_resource_group" "rg-test" {
    name = "generalrg"
    #location = "eastus"
}
/*
#adding a data block to read the variables for vm 3 and 4 (app gw)
/* data "external" "appgwvmslist" {
    program = ["powershell", ".\\readappgwvms.ps1"]
}#commented as ps is not giving desired  json o/p, retrying only with txt file
*/

#adding variable for ps script, to get o/p of tenant and objectid 
locals {
      #script_path ="azuredetails.ps1" #as the file is in the same folder else will need to specify
      #azuredetails_output = (data.external.azuredetails.result) #for 711kv
      #
      /*
      #this is giving an error if separate - ....ails.result is map of string with 2 elements
      tenant_id = jsondecode(data.external.azuredetails.result).tenant_id #jsondecode not needed
      object_id = jsondecode(data.external.azuredetails.result).object_id
      */
      #local variable for reading vm names and assigned to variable defined in variables tf -commented as powershell is not giving desired o/p
      #appgwvms_output = (data.external.appgwvmslist.result)  #not added in variables.tf (1 variable defined, unused)
      #appgwvms_output = [ split("\n", file("${path.module}/readappgwvms.txt"))]
      #appgwvms_output = toset(split("\n", chomp(file("${path.module}/readappgwvms.txt")))) #chomp to remove trail space
      /*appgwvms_output = [for vm in split("\n", chomp(file("${path.module}/readappgwvms.txt"))) : trimspace(vm)]
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
      */
      /*#for 711kv access policy
      key_vault_access_policy = [
            {
                tenant_id = local.azuredetails_output.tenant_id
                object_id = local.azuredetails_output.object_id
                key_permissions = ["Get"]
                secret_permissions = ["Get"]
                storage_permissions = ["Get"]
            }
      ]*/

} 
