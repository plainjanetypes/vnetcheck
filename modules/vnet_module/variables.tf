#adding variables to test a vnet module
variable "vnet_name" {
      description = "name of the vnet"
      type = string
}
variable "address_space" {
      description = "address space for the vnet"
      type = list(string)
}
variable "subnets" {
      description = "subnet names and address space"
      type = list(object({
            name = string
            address_prefix = string
      }))
}
variable "location" {
      type = string
}







/*#variable for 711 keyvault access policy
variable "keyvault711accesspolicy" {
      description = "access policy for key vault 711kv"
      type = list(object({
            tenant_id = string
            object_id = string
            application_id = string
            certificate_permissions = list(string)
            key_permissions = list(string)
            secret_permissions = list(string)
            storage_permissions = list(string)
      }))
}*/
