module "test-subnet" {
    source = "./modules/vnet_module"
    subnets = [
        {
            name = "subnet1"
            address_prefix = "10.0.1.0/24"
        }
    ]
    address_space = ["10.0.1.0/24"]
    location = "eastus"
    vnet_name = module.test-vnet.vnet_name
}
module "test-vnet" {
    source = "./modules/vnet_module"
    vnet_name = "test-vnet-1"
    address_space = ["10.0.0.0/16"]
    location = "eastus"
    subnets = module.test-subnet.subnets
}
