#variable to create multiple subnets
variable "subnets" {
        type = map(object({
          name = string
          address_prefix = string
        }))
    default = {
      "subnet2" = {
            name = "SensorSubnet1"
            address_prefix = "10.30.20.0/24"
      }
      "subnet3" = {
            name = "SensorSubnet2"
            address_prefix = "10.30.21.0/24"
      }
      "subnet4" = {
            name = "SensorSubnet3"
            address_prefix = "10.30.22.0/24"
      }
    }
}

#variable to create 2 dns vms, values picked from a text file
variable "dnsvms" {
  default = []
  type = list(string)
}