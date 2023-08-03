#creating a keyvault to store and reference vms passwords - but no tenant/object values can be referenced without apply - insane
/* resource "azurerm_key_vault" "azurekv" {
        name = "711KV"
        location = azurerm_resource_group.rgvnet.location
        resource_group_name = azurerm_resource_group.rgvnet.name
        enabled_for_disk_encryption = true
        tenant_id = local.tenant_id
        #tenant_id = data.azurerm_client_config.current.tenant_id #data references will work only after the changes have been applied, hence referencing via ps
        soft_delete_retention_days = 7
        purge_protection_enabled = true
        sku_name = "standard"
        access_policy = {
            #data references will work only after the changes have been applied, hence referencing via ps
            #tenant_id = data.azurerm_client_config.current.tenant_id
            #object_id = data.azurerm_client_config.current.object_id
            tenant_id = local.tenant_id
            object_id = local.object_id

            key_permissions = ["Get"]
            secret_permissions = ["Get"]
            storage_permissions = ["Get"]
        }
} */