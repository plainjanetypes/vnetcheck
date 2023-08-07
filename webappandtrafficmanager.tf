#creating a traffic manager - first 2instances of a webapp deployed in 2 diff regions will be created

#create resource group 1 eaastus
resource "azurerm_resource_group" "webapprg1" {
    name = "Cos-RG-TM1"
    location = "eastus"
}
#create resource group 2 weu
resource "azurerm_resource_group" "webapprg2" {
    name = "Cos-RG-TM2"
    location = "westeurope"
}

#create app service plan 1 - azurerm_app_service_plan deprecated and will be removed in 4.0 - for multiple web apps
resource "azurerm_service_plan" "cosserviceplan1" {
    name = "CosAppServicePlanEastUS"
    location = azurerm_resource_group.webapprg1.location
    resource_group_name = azurerm_resource_group.webapprg1.name
    os_type = "Windows"
    #reserved = true #true if os type is linux, else false
    sku_name = "F1"

}
#create web app 1 - azurerm_app_service deprecated and will be removed in 4.0
resource "azurerm_windows_web_app" "coswebapp1" {
    name = "CosWebApp1EastUSTS"
    location = azurerm_resource_group.webapprg1.location
    resource_group_name = azurerm_resource_group.webapprg1.name
    service_plan_id = azurerm_service_plan.cosserviceplan1.id
    site_config {
      #dotnet_framework_version = "v4.8" # was valid for azurerm_app_service , v3.0
    }
}
#create app service plan 2
resource "azurerm_service_plan" "cosserviceplan2" {
    name = "CosAppServicePlanWestEurope"
    location = azurerm_resource_group.webapprg2.location
    resource_group_name = azurerm_resource_group.webapprg2.name
    os_type = "Windows"
    sku_name = "F1"
}

#create web app 2
resource "azurerm_windows_web_app" "coswebapp2" {
    name = "CosWebApp1WEUTS"
    location = azurerm_resource_group.webapprg2.location
    resource_group_name = azurerm_resource_group.webapprg2.name
    service_plan_id = azurerm_service_plan.cosserviceplan2.id
    site_config {
      #dotnet_framework_version = "v4.8" # was valid for azurerm_app_service , v3.0
    }
}
#create a traffic manager profile
resource "azurerm_traffic_manager_profile" "webtrafficmgr" {
    name = "Cos-TMProfileTS"
    resource_group_name = azurerm_resource_group.webapprg1.name
    traffic_routing_method = "Priority"

    dns_config {
        relative_name = "xc100"
        ttl = 100
    } 
    monitor_config {
        protocol = "HTTPS"
        port = 443
        path = "/"
        interval_in_seconds = 30
        timeout_in_seconds =  9
        tolerated_number_of_failures = 5
    }
}
#create traffic manager endpoints
#primary endpoint
resource "azurerm_traffic_manager_azure_endpoint" "primaryendpoint" {
    name = "myPrimaryEndpoint"
    profile_id = azurerm_traffic_manager_profile.webtrafficmgr.id
    weight = 100
    priority = 1
    target_resource_id = azurerm_windows_web_app.coswebapp1.id
  
}
#failoverendpoint
resource "azurerm_traffic_manager_azure_endpoint" "failoverendpoint" {
    name = "myFailoverEndpoint"
    profile_id = azurerm_traffic_manager_profile.webtrafficmgr.id
    priority = 2
    weight = 100
    target_resource_id = azurerm_windows_web_app.coswebapp2.id 
}