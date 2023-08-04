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
          subnet_id = azurerm_subnet.subnet2frontend.id
            }
        }
resource "azurerm_lb_backend_address_pool" "backendpool" {
        name = "myBackendPool"
        loadbalancer_id = azurerm_lb.lbint.id
        virtual_network_id = azurerm_virtual_network.lbvnet.id
} #to add vms to the backend pool, add the backendpoolids to the nic

#create a health probe
resource "azurerm_lb_probe" "lbprobe" {
        name = "myHealthProbe"
        loadbalancer_id = azurerm_lb.lbint.id
        protocol = "Http"
        port = 80
        interval_in_seconds = 15
        #unhealthy_threshold = 2
        request_path = "/" 
}

#create a load balancer rule
resource "azurerm_lb_rule" "lbrule" {
        name = "myHTTPRule"
        loadbalancer_id = azurerm_lb.lbint.id
        protocol = "Tcp"
        frontend_port = "80"
        backend_port = "80"
        frontend_ip_configuration_name = azurerm_public_ip.lbip.name
        #backend_address_pool_ids = 
        #probe_id = 
        }
