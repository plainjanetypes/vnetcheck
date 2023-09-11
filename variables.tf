


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
