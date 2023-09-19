#creating a keyvault to store and reference vms passwords - but no tenant/object values can be referenced without vault apply - insane
#but it means, move it to a diff state
/*
#keyvault should be primary pre req and be singularly deployed
resource "azurerm_key_vault" "azurekv" {
  name                        = "711KV"
  location                    = azurerm_resource_group.rgvnet.location
  resource_group_name         = azurerm_resource_group.rgvnet.name
  enabled_for_disk_encryption = true
  tenant_id                   = local.azuredetails_output.tenant_id
  #tenant_id                  = data.azurerm_client_config.current.tenant_id #data references will work only after the changes have been applied, hence referencing via ps
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true
  sku_name                    = "standard"
  access_policy               = var.keyvault711accesspolicy
}*/
/*
{
#data references will work only after the changes have been applied, hence referencing via ps but will not work till apply
tenant_id = local.azuredetails_output.tenant_id
object_id = local.azuredetails_output.object_id

key_permissions = ["Get"]
secret_permissions = ["Get"]
storage_permissions = ["Get"]
#to overcome - defined a variable with access policy, referenced to ensure all vlaues populate at runtime
}*/
