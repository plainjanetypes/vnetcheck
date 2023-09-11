#creating a front door for 2 instance of a web app running in different regions
#creating a separate RG
resource "azurerm_resource_group" "frontdoortestrg" {
    name = "FrontdoorTestRG"
    location = "eastus"  
}

#create a webapp plan 1 - central us
resource "azurerm_service_plan" "appplancentralus" {
    name = "CosAppFrondoorTestServicePlanCUS"
    location = azurerm_resource_group.frontdoortestrg.location
    resource_group_name = azurerm_resource_group.frontdoortestrg.name
    os_type = "Windows"
    sku_name = "F1"
}

#create a webapp plan 2 - east us
resource "azurerm_service_plan" "appplaneastus" {
    name = "CosAppFrondoorTestServicePlanEUS"
    location = azurerm_resource_group.frontdoortestrg.location
    resource_group_name = azurerm_resource_group.frontdoortestrg.name
    os_type = "Windows"
    sku_name = "F1"
}

#create a web app instance 1 - central us
resource "azurerm_windows_web_app" "frontwebappcentralus" {
    name = "CosWebApp1CUS"
    location = "centralus"
    resource_group_name = azurerm_resource_group.frontdoortestrg.name
    service_plan_id = azurerm_service_plan.appplancentralus.id
    site_config {
      #dotnet_framework_version = "v4.8" # was valid for azurerm_app_service , v3.0
    }
}
#create a web app instance 2 - east us
resource "azurerm_windows_web_app" "frontwebappeastus" {
    name = "CosWebApp2EUS"
    location = azurerm_resource_group.frontdoortestrg.location
    resource_group_name = azurerm_resource_group.frontdoortestrg.name
    service_plan_id = azurerm_service_plan.appplaneastus.id
    site_config {
      #dotnet_framework_version = "v4.8" # was valid for azurerm_app_service , v3.0
    }
}

/*#create a front door - classic instance, will receive only security updates/deprecated 
resource "azurerm_frontdoor" "frontdoorce" {
    name = "FrontDoorTS"
    resource_group_name = azurerm_resource_group.frontdoortestrg.name
    routing_rule {
      name = "routingrule1"
      accepted_protocols = ["Http","Https"]
      patterns_to_match = ["/*"]
      frontend_endpoints = ["FDendpoint"]
      forwarding_configuration {
        forwarding_protocol =  "MatchRequest"
        backend_pool_name = "BackendBing"
      }
    }
} */
#creating front door premium 
#WEBAPPS need to be deployed first to use it
/* resource "azurerm_cdn_profile" "frontdoorce" {
    name = "FrontDoorTS"
    resource_group_name = azurerm_resource_group.frontdoortestrg.name
    location = azurerm_resource_group.frontdoortestrg.name
    sku = "Standard.Microsoft"

    dynamic "endpoint" {
        for_each = [1,2] #number of endpoints (webapps)
        content {
            name = "FDEndpoints${endpoint.key}"
            is_http_allowed = true
            is_https_allowed = true
            origin_host_header = "webapp${endpoint.key}.azurewebsites.net"  # actual web app hostnames
            origin_path = "/"
            custom_origin {
                http_port = 80
                https_port = 443
                origin_path = "/"
                origin_host_header = "webapp${endpoint.key}.azurewebsites.net" 
            }
        }
      
    }
} */ #need to fix error 