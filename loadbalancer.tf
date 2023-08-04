# load balancer in vnet  with a backendsubnet + 3 vms in 1-3 zones
#create a public ip for the load balancer
resource "azurerm_public_ip" "lbip" {
    name = "LoadBalancerFrontEnd"
    location = azurerm_resource_group.lbrg.location
    resource_group_name = azurerm_resource_group.lbrg.name
    allocation_method = "Dynamic"
}

#creating load balancer 
resource "azurerm_lb" "lbint" {
        name = "myIntLoadBalancer"
        resource_group_name = azurerm_resource_group.lbrg.name
        location = azurerm_resource_group.lbrg.location
        sku = "Standard"

        frontend_ip_configuration {
          name = "PublicIPLB"
          public_ip_address_id = azurerm_public_ip.lbip.id
        }



}
  
