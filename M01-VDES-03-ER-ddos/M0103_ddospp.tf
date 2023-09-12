#configure ddos protection on a vnet (new vs existing)
#only 1 ddos protection plan allowed per region, it is VERY costly

#ddos for an existing vnet - coreservices - vnet1
resource "azurerm_network_ddos_protection_plan" "coreddosplan" {
    name = "CoreDdoSProtectionPlan"
    location = azurerm_resource_group.rgvnet.location
    resource_group_name = azurerm_resource_group.rgvnet.name 
    #no vnet relationship drama - add a reference in the vnet block

    tags = {
        module = "M06"
        totest = "DDos-protect"
    }
}

#configure DDos diagnostic logs
#configure DDos telemetry

#creating a log analytics workspace - will be used only for this
resource "azurerm_log_analytics_workspace" "ddoslaws" {
    name = "ddoslaws"
    resource_group_name = azurerm_resource_group.rgvnet.name
    location = "eastus"
        tags = {
        module = "M06"
        totest = "DDos-protect"
    }
}

#azure monitoring at vnet level - storage account used
resource "azurerm_monitor_diagnostic_setting" "ddoslogs" {
        name = "ddosdiag-logs"
        target_resource_id = azurerm_virtual_network.vnet1coreservices.id
        #using existing storage account
        storage_account_id = data.azurerm_storage_account.diagstorage.id
        log_analytics_workspace_id = azurerm_log_analytics_workspace.ddoslaws.id
        enabled_log {
          category = "DDoSMitigationFlowLogs"
          retention_policy {
            enabled = true
              }
            }
        enabled_log {
          category = "DDosProtectionNotifications"
          retention_policy {
            enabled = true 
          }
          }
        enabled_log {
          category = "DDosMitigationReports"
          retention_policy {
            enabled = true
          }
        }
        metric {
          category = "AllMetrics"
        }
}

#alternatively - create a public ip, assign to a vm, enable ddos logs and alerts on the public ip
#create a public ip
resource "azurerm_public_ip" "ddostestvm-pip" {
        name = "ddos-test-vm-pip"
        location = "eastus"
        resource_group_name = azurerm_resource_group.rgvnet.name
        allocation_method = "Dynamic"
        ddos_protection_plan_id = azurerm_network_ddos_protection_plan.coreddosplan.id #associate the ip to ddos plan
        tags = {
        module = "M06"
        totest = "DDos-protect"
    }
}
#network interface
resource "azurerm_network_interface" "ddos-test-vm-nic" {
        name = "ddos-test-vm-nic"
        location = azurerm_resource_group.rgvnet.location
        resource_group_name = azurerm_resource_group.rgvnet.name
        ip_configuration {
          subnet_id = azurerm_virtual_network.vnet1coreservices.id
          private_ip_address_allocation = "Dynamic"
          name = "pvt-ip-ddos-test-vm"
          public_ip_address_id = azurerm_public_ip.ddostestvm-pip.id
        }
        tags = {
        module = "M06"
        totest = "DDos-protect"
    }
}

#create the vm 
resource "azurerm_windows_virtual_machine" "ddos-test-vm" {
    name = "DDos-test-VM"
    resource_group_name = azurerm_resource_group.rgvnet.name
    location = azurerm_resource_group.rgvnet.location
    network_interface_ids = [azurerm_network_interface.ddos-test-vm-nic.id]
    admin_username = "vmadmin"
    admin_password = "Welcome@12345" #use keyvault for prod

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

    tags = {
      module = "M06"
      totest = "DDos-protect"
    }
}

#create an action group
resource "azurerm_monitor_action_group" "ddos-alert-action" {
      name = "ddos-action-group"
      resource_group_name = azurerm_resource_group.rgvnet.name
      location = azurerm_resource_group.rgvnet.location
      short_name = "ddos-alert"
      email_receiver {
        name = "tanush"  # key vault?
        email_address = "tanush@pl.com" #key vault
      }
  
}
#configure a monitoring alert
resource "azurerm_monitor_metric_alert" "ddos-alert" {
      name = "ddos-alert"
      resource_group_name = azurerm_resource_group.rgvnet.name
      scopes = [azurerm_public_ip.ddostestvm-pip.id]
      description = "Alert for DDos attack"
      severity = 3

      criteria {
        metric_namespace = "Microsoft.Network/PublicIPAddresses"
        metric_name = "Inbound DDoS Attack Packets"
        aggregation = "Total"
        operator = "GreaterThan"
        threshold = 1
        }
      action {
        action_group_id = azurerm_monitor_action_group.ddos-alert-action.id
      }
  
}

#simulate a ddos attack using  BreakingPoint Cloud