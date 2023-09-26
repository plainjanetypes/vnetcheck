data "azurerm_storage_account" "diagstorage" {
    name = "terrageneral"
    resource_group_name = "generalrg"
}
data "azurerm_key_vault" "genkv" {
    name = "generalkv2508"
    resource_group_name = "generalrg"
}
data "azurerm_key_vault_secret" "genkvsecret-700-deployer-tenant-id" {
    name = "700-deployer-tenant-id"
    key_vault_id = "/subscriptions/a87b2fd2-98c1-4751-9689-5bc24a57d50a/resourceGroups/generalrg/providers/Microsoft.KeyVault/vaults/generalkv2508"
}
data "azurerm_key_vault_secret" "genkvsecret-700-deployer-client-id" {
    name = "700-deployer-client-id"
    key_vault_id = "/subscriptions/a87b2fd2-98c1-4751-9689-5bc24a57d50a/resourceGroups/generalrg/providers/Microsoft.KeyVault/vaults/generalkv2508"
}
data "azurerm_key_vault_secret" "genkvsecret-700-deployer-kv-secret" {
    name = "700-deployer-kv-secret"
    key_vault_id = "/subscriptions/a87b2fd2-98c1-4751-9689-5bc24a57d50a/resourceGroups/generalrg/providers/Microsoft.KeyVault/vaults/generalkv2508"
}
data "azurerm_key_vault_secret" "genkvsecret-700-deployer-kv-sub-id" {
    name = "700-deployer-kv-sub-id"
    key_vault_id = "/subscriptions/a87b2fd2-98c1-4751-9689-5bc24a57d50a/resourceGroups/generalrg/providers/Microsoft.KeyVault/vaults/generalkv2508"
}
locals {
  dnsvms = split("\n",(file("M0103_dnsvmsnames.txt")))
  sub-id-700 = data.azurerm_key_vault_secret.genkvsecret-700-deployer-kv-sub-id
  secret-id-700 = data.azurerm_key_vault_secret.genkvsecret-700-deployer-kv-secret
  client-id-700 = data.azurerm_key_vault_secret.genkvsecret-700-deployer-client-id
  tenant-id-700 = data.azurerm_key_vault_secret.genkvsecret-700-deployer-tenant-id
  
}